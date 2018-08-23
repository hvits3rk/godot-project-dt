extends KinematicBody2D

enum {
	IDLE,
	MOVE,
	ATTACK,
	FOLLOW,
	CHASE
}

signal state_changed(states_stack)

const ray_length = 1000

export(float) var SPOT_RANGE = 200.0
export(float) var FOLLOW_RANGE = 100.0
export(float) var ROAM_RADIUS = 140.0

onready var Anim = get_node("AnimationPlayer")
onready var stats = get_node("Stats")
onready var camera = get_node("Camera2D")
onready var pivot = get_node("Pivot")
onready var direct_space = get_viewport().get_world_2d().get_direct_space_state()

# == Player States ==
onready var IdleState = get_node("States/Idle")
onready var WalkState = get_node("States/Walk")
onready var AttackState = get_node("States/Attack")
onready var FollowState = get_node("States/Follow")
onready var ChaseState = get_node("States/Chase")

var move_position = Vector2()
var target = self

var event
var states_stack = []
var new_state

# == override functions ==
func _ready():
	$Debug/Moving.setup(global_position, ROAM_RADIUS, SPOT_RANGE, FOLLOW_RANGE)
	Anim.play("INIT")
	event = IDLE
	states_stack.push_front(IdleState)
	states_stack.front().enter()
	move_position = global_position
	var interactable_charaters = get_tree().get_nodes_in_group("interactable_character")
	for character in interactable_charaters:
		character.get_node("InteractArea").connect("on_character_clicked", self, "_on_interactable_character_clicked")
	emit_signal("state_changed", states_stack)


func _unhandled_input(input):
	event = _get_event_from_input(input)
	new_state = states_stack.front().handle_event(event)
	if new_state:
		append_state(new_state)


func _physics_process(delta):
	if states_stack.front().update(delta):
		states_stack.front().exit()
		states_stack.pop_front()
		states_stack.front().enter()
		emit_signal("state_changed", states_stack)


# == public functions ==
func change_state(state):
	if states_stack.size() > 1:
		states_stack.front().exit()
		states_stack.pop_front()
		states_stack.push_front(state)
		states_stack.front().enter()
		emit_signal("state_changed", states_stack)
	else:
		append_state(state)

func append_state(state):
	states_stack.front().exit()
	states_stack.push_front(state)
	states_stack.front().enter()
	emit_signal("state_changed", states_stack)


func clear_state_stack():
	while states_stack.size() > 1:
		states_stack.front().exit()
		states_stack.pop_front()
		emit_signal("state_changed", states_stack)


func look_at_position(pos):
	var abs_pivot_scale_x = abs(pivot.scale.x)
	if position.x - pos.x > 0:
		pivot.scale.x = -abs_pivot_scale_x
	else:
		pivot.scale.x = abs_pivot_scale_x


# == private functions ==
func _get_event_from_input(input):
	if input == null:
		return null
	
	if input.is_action_pressed("left_click"):
		var array = direct_space.intersect_point(get_global_mouse_position())
		
		if array.empty():
			move_position = get_global_mouse_position()
			return MOVE
	
	return null


func _on_interactable_character_clicked(character):
	target = character
	if target.is_in_group("enemy") and target.is_in_group("interactable_character"):
		print("Player._on_interactable_character_clicked(): %s is enemy" % [character.name])
		new_state = states_stack.front().handle_event(ATTACK)
	
	if new_state:
		clear_state_stack()
		append_state(new_state)
