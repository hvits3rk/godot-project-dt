extends "res://scripts/character/player/states/StateBase.gd"

var state_name = "chase"

var cur_target = null
var velocity = Vector2()
var position_to_move = Vector2()
var recalc_timer = 0


func handle_event(event):
	match event:
		host.ATTACK:
			if host.target != null and cur_target == host.target:
				return null
				
			print("ChaseState: handle_event() -> ATTACK")
			return { append = false, state = host.attack_state }
		host.MOVE:
			print("ChaseState: handle_event() -> MOVE")
			return { append = false, state = host.walk_state }
		_:
			return null


func enter():
	print("ChaseState: enter()")
	cur_target = host.target
	velocity.x = 0
	velocity.y = 0
	recalc_timer = 0
	anim.get_animation("walk").loop = true
	anim.play("walk", 0.1)


func update(delta):
	position_to_move = host.target.position - host.position
	
	recalc_timer -= delta;
	if recalc_timer <= 0:
		recalc_timer = 0.1
		host.look_at_position(host.target.position)
		velocity = position_to_move.normalized() * host.stats.speed
	
	if position_to_move.length() < host.stats.attack_radius - 10:
		return true
	
	host.move_and_slide(velocity)
	
	return false


func exit():
	print("ChaseState: exit()")
	anim.get_animation("walk").loop = false
