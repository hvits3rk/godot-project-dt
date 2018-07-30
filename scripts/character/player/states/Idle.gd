extends "res://scripts/character/player/states/StateBase.gd"


func handle_event(event):
	match event:
		host.MOVE:
			print("IdleState: handle_event() -> MOVE")
			return host.WalkState
		host.ATTACK:
			print("IdleState: handle_event() -> ATTACK")
			return host.AttackState
		_:
			return null


func enter():
	print("IdleState: enter()")
	if host.Anim.current_animation != "idle":
		if host.Anim.is_playing():
			yield(host.Anim, "animation_finished")
			host.Anim.stop()
		host.Anim.get_animation("idle").loop = true
		host.Anim.play("idle")


func update(delta):
	return false


func exit():
	print("IdleState: exit()")
	host.Anim.get_animation("idle").loop = false
