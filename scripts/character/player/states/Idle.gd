extends "res://scripts/character/player/states/StateBase.gd"


func handle_event(event):
	match event:
		host.MOVE:
			print("IdleState: handle_event() -> MOVE")
			return host.WalkState
		host.ATTACK:
			print("IdleState: handle_event() -> ATTACK")
			return host.AttackState
		host.FOLLOW:
			print("IdleState: handle_event() -> FOLLOW")
			return host.FollowState
		_:
			return null


func enter():
	print("IdleState: enter()")
	host.Anim.get_animation("idle").loop = true
	host.Anim.play("idle")


func update(delta):
	return false


func exit():
	print("IdleState: exit()")
	host.Anim.get_animation("idle").loop = false
	if host.Anim.is_playing():
		host.Anim.stop()
		host.Anim.play("INIT")
