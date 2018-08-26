extends KinematicBody2D

enum {
	IDLE,
	MOVE,
	ATTACK,
	FOLLOW,
	CHASE
}

signal state_changed(states_stack)

# == Player States ==
onready var idle_state = get_node("States/Idle")
onready var walk_state = get_node("States/Walk")
onready var attack_state = get_node("States/Attack")
onready var follow_state = get_node("States/Follow")
onready var chase_state = get_node("States/Chase")

onready var anim = get_node("AnimationPlayer")
onready var stats = get_node("Stats")
onready var pivot = get_node("Pivot")
onready var inputController = get_node("InputController")

var move_position = Vector2()
var target = null

var states_stack = []


func _ready():
	inputController.connect("command_occurred", self, "_on_InputController_command_occurred")
	anim.play("INIT")
	states_stack.push_front(idle_state)
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


func look_at_position(pos):
	var abs_pivot_scale_x = abs(pivot.scale.x)
	if position.x - pos.x > 0:
		pivot.scale.x = -abs_pivot_scale_x
	else:
		pivot.scale.x = abs_pivot_scale_x


func clear_states_stack():
	while states_stack.size() > 1:
		states_stack.pop_front().exit()
		states_stack.front().enter()


func _on_InputController_command_occurred(command, object):
	if object.has("move_position"):
		move_position = object.move_position
	elif object.has("target"):
		target = object.target
	var new_state = states_stack.front().handle_event(command)
	if new_state:
		if new_state.append:
			append_state(new_state.state)
		else:
			change_state(new_state.state)
