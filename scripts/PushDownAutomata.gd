extends Node

var states_stack = []
var current_state

onready var States = get_node("States")

func _ready():
	current_state = States.INIT
	states_stack.push_front(States.InitState.new())
	states_stack.front().enter(self)

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
		return
	var exited_state = states_stack.pop_front()
	exited_state.exit(self)
	exited_state.queue_free()
	states_stack.front().enter(self)

func clear_states_stack():
	while end_current_state():
		pass

func _exit_tree():
	clear_states_stack()
	var exited_state = states_stack.pop_front()
	exited_state.exit(self)
	exited_state.queue_free()
