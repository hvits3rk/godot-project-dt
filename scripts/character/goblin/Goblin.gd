extends KinematicBody2D

export(float) var SPOT_RANGE = 200.0
export(float) var FOLLOW_RANGE = 100.0
export(float) var ROAM_RADIUS = 140.0

var route = [
	Vector2(100, 100),
	Vector2(600, 100),
	Vector2(600, 600),
	Vector2(100, 600)
]

var nextPosition = 0
var vec_to_move_position
var recalc_timer = 0

export(String) var NAME = "Goblin"

onready var stats = get_node("Stats")

var velocity = Vector2()

func _ready():
	$Debug/Moving.setup(global_position, ROAM_RADIUS, SPOT_RANGE, FOLLOW_RANGE)

func _physics_process(delta):
	vec_to_move_position = route[nextPosition] - position
	
	recalc_timer -= delta;
	if recalc_timer <= 0:
		recalc_timer = 0.1
		velocity = vec_to_move_position.normalized() * 180
	
	if vec_to_move_position.length() < 5:
		nextPosition += 1
		nextPosition %= 4
	
	move_and_slide(velocity)
