extends Node

onready var host = get_parent().get_parent()


func handle_event(event):
	return null


func enter():
	pass


# if state finished its job - return true
func update(delta):
	return false


func exit():
	pass