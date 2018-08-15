extends KinematicBody2D

export(float) var SPOT_RANGE = 200.0
export(float) var FOLLOW_RANGE = 100.0
export(float) var ROAM_RADIUS = 140.0

export(String) var NAME = "Goblin"

onready var stats = get_node("Stats")

var velocity = Vector2()

func _ready():
	$Debug/Moving.setup(global_position, ROAM_RADIUS, SPOT_RANGE, FOLLOW_RANGE)
	velocity.x = 50

func _physics_process(delta):
	move_and_slide(velocity)
