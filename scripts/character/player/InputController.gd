extends Node2D

signal command_occurred(command, object)

onready var player = get_parent()
onready var direct_space = get_viewport().get_world_2d().get_direct_space_state()


func _ready():
	var interactable_charaters = get_tree().get_nodes_in_group("interactable_character")
	for character in interactable_charaters:
		character.get_node("InteractableArea").connect("on_character_clicked", self, "_on_interactable_character_clicked")


func _unhandled_input(input):
	if input.is_action_pressed("left_click"):
		var array = direct_space.intersect_point(get_global_mouse_position(), 1)
		
		if array.empty():
			var position_to_move = get_global_mouse_position()
			emit_signal("command_occurred", player.MOVE, { move_position = position_to_move })


func _on_interactable_character_clicked(character):
	if character.is_in_group("enemy") and character.is_in_group("interactable_character"):
		emit_signal("command_occurred", player.ATTACK, { target = character })
