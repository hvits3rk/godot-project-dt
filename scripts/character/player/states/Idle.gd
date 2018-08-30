extends "res://scripts/character/player/states/StateBase.gd"

var state_name = "idle"

func handle_event(event):
	match event:
		host.MOVE:
			print("IdleState: handle_event() -> MOVE")
			return { append = true, state = host.walk_state }
		host.ATTACK:
			print("IdleState: handle_event() -> ATTACK")
			return { append = true, state = host.attack_state }
		_:
			return null


func enter():
	print("IdleState: enter()")
	anim.get_animation("idle").loop = true
	anim.queue("idle")


func update(delta):
	return false


func exit():
	print("IdleState: exit()")
	anim.get_animation("idle").loop = false
