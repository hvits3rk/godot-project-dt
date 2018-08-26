extends "res://scripts/character/player/states/StateBase.gd"

var state_name = "walk"

var velocity = Vector2()
var position_to_move = Vector2()
var recalc_timer = 0

func handle_event(event):
	match event:
		host.ATTACK:
			print("WalkState: handle_event() -> ATTACK")
			return { append = false, state = host.attack_state }
		_:
			return null


func enter():
	print("WalkState: enter()")
	velocity.x = 0
	velocity.y = 0
	recalc_timer = 0
	anim.get_animation("walk").loop = true
	anim.play("walk", 0.1)


func update(delta):
	position_to_move = host.move_position - host.position
	
	recalc_timer -= delta;
	if recalc_timer <= 0:
		recalc_timer = 0.1
		velocity = position_to_move.normalized() * host.stats.speed
		host.look_at_position(position_to_move)
	
	if position_to_move.length() < 5:
		return true
	
	host.move_and_slide(velocity)
	
	return false


func exit():
	print("WalkState: exit()")
	anim.get_animation("walk").loop = false
