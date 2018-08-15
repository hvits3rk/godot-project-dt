extends Area2D

signal on_character_clicked(character)

onready var Char = get_parent()

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		emit_signal("on_character_clicked", Char)