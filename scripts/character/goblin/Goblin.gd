extends KinematicBody2D

onready var anim = get_node("AnimationPlayer")
onready var pivot = get_node("Pivot")
onready var stats = get_node("Stats")
onready var backpack = get_node("Backpack")


func look_at_position(pos):
	var abs_pivot_scale_x = abs(pivot.scale.x)
	if position.x - pos.x > 0:
		pivot.scale.x = -abs_pivot_scale_x
	else:
		pivot.scale.x = abs_pivot_scale_x
