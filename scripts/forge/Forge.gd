extends Node

signal state_changed
signal progress_changed
signal item_created

onready var ForgeGui = get_node("ForgeGui")
onready var States = get_node("States")

const Constants = preload("res://scripts/forge/common/Constants.gd")

var progress = 0

var states_stack = []
var current_state

var item_in_production = {}

func _ready():
	ForgeGui.connect("production_started", self, "_on_ForgeGui_production_started")
	current_state = States.IDLE
	states_stack.push_front(States.IdleState.new())
	states_stack.front().enter(self)
	emit_signal("progress_changed", progress)

func _process(delta):
	if states_stack.front().update(self, delta):
		end_current_state()

func append_state(state):
	var new_state = states_stack.front().handle_event(self, state)
	if new_state:
		current_state = state
		states_stack.push_front(new_state)
		states_stack.front().enter(self)
		set_process(true)

func replace_state(state):
	var new_state = states_stack.front().handle_event(self, state)
	if new_state:
		current_state = state
		var exited_state = states_stack.pop_front()
		exited_state.exit(self)
		exited_state.queue_free()
		states_stack.push_front(new_state)
		states_stack.front().enter(self)
		set_process(true)

func end_current_state():
	if states_stack.size() <= 1:
		print("Forge: Cant end current state, states_stack.size(): %d" % states_stack.size())
		return
	var exited_state = states_stack.pop_front()
	exited_state.exit(self)
	exited_state.queue_free()
	states_stack.front().enter(self)

func clear_states_stack():
	while end_current_state():
		pass

## == connected signal methods ==
func _on_ForgeGui_production_started(item_model):
	item_in_production = item_model.duplicate()
	append_state(States.CREATING_ITEM)

func _exit_tree():
	clear_states_stack()
	var exited_state = states_stack.pop_front()
	exited_state.exit(self)
	exited_state.queue_free()