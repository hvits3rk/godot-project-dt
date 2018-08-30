extends Node

# Это FSM нашего ИИ

signal state_changed(states_stack)

onready var character = get_parent().get_parent()
onready var planner = get_node("GoapPlanner")
onready var data_provider = get_parent()
onready var idle_state = get_node("States/IdleState")
onready var move_state = get_node("States/MoveState")
onready var action_state = get_node("States/ActionState")
onready var available_actions = get_node("GoapActions").get_children()

var current_actions = []
var states_stack = []


func _ready():
	states_stack.push_front(action_state)
	states_stack.front().enter()
	emit_signal("state_changed", states_stack)


func _physics_process(delta):
	if states_stack.front().update(delta):
		states_stack.pop_front().exit()
		states_stack.front().enter()
		emit_signal("state_changed", states_stack)


func change_state(new_state):
	clear_states_stack()
	states_stack.push_front(new_state)
	states_stack.front().enter()
	emit_signal("state_changed", states_stack)


func append_state(new_state):
	states_stack.front().exit()
	states_stack.push_front(new_state)
	states_stack.front().enter()
	emit_signal("state_changed", states_stack)


func clear_states_stack():
	while states_stack.size() > 1:
		states_stack.pop_front().exit()
		states_stack.front().enter()


func has_action_plan():
	return current_actions.size() > 0
