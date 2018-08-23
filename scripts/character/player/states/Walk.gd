extends "res://scripts/character/player/states/StateBase.gd"

var velocity = Vector2()
var vec_to_move_position = Vector2()
var recalc_timer = 0

func handle_event(event):
	match event:
		host.IDLE:
			print("WalkState: handle_event() -> IDLE")
			return host.IdleState
		host.ATTACK:
			print("WalkState: handle_event() -> ATTACK")
			return host.AttackState
		host.FOLLOW:
			print("WalkState: handle_event() -> FOLLOW")
			return host.FollowState
		_:
			return null


func enter():
	print("WalkState: enter()")
	velocity.x = 0
	velocity.y = 0
	recalc_timer = 0
	host.Anim.get_animation("walk").loop = true
	host.Anim.play("walk", 0.1)


func update(delta):
	vec_to_move_position = host.move_position - host.position
	
	recalc_timer -= delta;
	if recalc_timer <= 0:
		recalc_timer = 0.1
		velocity = vec_to_move_position.normalized() * host.stats.speed
		host.look_at_position(host.move_position)
	
	if vec_to_move_position.length() < 5:
		return true
	
	host.move_and_slide(velocity)
	
	return false


func exit():
	print("WalkState: exit()")
	host.Anim.get_animation("walk").loop = false
