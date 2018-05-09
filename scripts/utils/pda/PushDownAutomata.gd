extends Node

signal state_changed

var states_stack = []
var current_state

onready var States = get_node("States")
onready var Host = get_parent()

func _ready():
	current_state = States.INIT
	states_stack.push_front(States.InitState)
	states_stack.front().enter(Host)

func _process(delta):
	if states_stack.front().update(Host, delta):
		end_current_state()

func append_state(state):
	var new_state = states_stack.front().handle_event(Host, state)
	if new_state:
		states_stack.front().exit(Host)
		print(states_stack.front())
		current_state = state
		states_stack.push_front(new_state)
		states_stack.front().enter(Host)
		set_process(true)

func replace_state(state):
	var new_state = states_stack.front().handle_event(Host, state)
	if new_state:
		current_state = state
		var exited_state = states_stack.pop_front()
		exited_state.exit(Host)
		states_stack.push_front(new_state)
		states_stack.front().enter(Host)
		set_process(true)

func end_current_state():
	if states_stack.size() <= 1:
		return
	var exited_state = states_stack.pop_front()
	exited_state.exit(Host)
	states_stack.front().enter(Host)
	set_process(true)

func clear_states_stack():
	while end_current_state():
		pass

#func _exit_tree():
#	clear_states_stack()
#	var exited_state = states_stack.pop_front()
#	exited_state.exit(Host)
