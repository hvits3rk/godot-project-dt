extends Node

signal state_changed
signal progress_changed
signal item_created

onready var ForgeGui = get_node("ForgeGui")
onready var States = get_node("States")

const Constants = preload("res://scripts/forge/common/Constants.gd")

var progress = 0

var states_stack = []
var forge_state

var item_in_production = {}

func _ready():
	ForgeGui.connect("production_started", self, "_on_ForgeGui_production_started")
	forge_state = States.IDLE
	states_stack.push_front(States.IdleState.new())
	emit_signal("state_changed", forge_state)
	emit_signal("progress_changed", progress)

func _process(delta):
	if states_stack.front().update(self, delta):
		states_stack.pop_front().exit(self)

func set_state(state):
	var new_state = states_stack.front().handle_input(self, state)
	if new_state:
		forge_state = state
		emit_signal("state_changed", forge_state)
		states_stack.push_front(new_state)
		states_stack.front().enter(self)
		set_process(true)

## == connected signal methods ==
func _on_ForgeGui_production_started(item):
	set_state(States.CREATING_ITEM)
	emit_signal("state_changed", forge_state)