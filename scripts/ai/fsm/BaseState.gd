extends Node

onready var agent = get_parent().get_parent()
onready var data_provider = agent.get_parent()
onready var character = data_provider.get_parent()
onready var interactable_area = character.get_node("InteractableArea")
onready var anim = character.get_node("AnimationPlayer")


func handle_event(event):
	return null


func enter():
	pass


func update(delta):
	return false


func exit():
	pass