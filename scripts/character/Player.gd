extends KinematicBody2D

enum {
	IDLE,
	MOVE,
	ATTACK
}

signal state_changed(state_name)

onready var Anim = get_node("AnimationPlayer")

# == Player States ==
onready var IdleState = get_node("States/Idle")
onready var WalkState = get_node("States/Walk")
onready var AttackState = get_node("States/Attack")

var target = Vector2()

var event
var states_stack = []
var new_state

# == override functions ==
func _ready():
	Anim.play("INIT")
	event = IDLE
	states_stack.push_front(IdleState)
	states_stack.front().enter()
	target = global_position


func _unhandled_input(input):
	event = _get_event_from_input(input)
	new_state = states_stack.front().handle_event(event)
	if new_state:
		change_state(new_state)


func _physics_process(delta):
	if states_stack.front().update(delta):
		states_stack.front().exit()
		states_stack.pop_front()
		states_stack.front().enter()


# == public functions ==
func change_state(state):
	if states_stack.front() != null:
		states_stack.front().exit()
	states_stack.push_front(state)
	states_stack.front().enter()


# == private functions ==
func _get_event_from_input(input):
	if input == null:
		return null
	if input.is_action_pressed("left_click"):
		# check the place clicked if ground - move
		target = input.position
		return MOVE

