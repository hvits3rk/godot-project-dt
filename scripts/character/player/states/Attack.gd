extends "res://scripts/character/player/states/StateBase.gd"

var vec_to_move_position = Vector2()
var attacked = false

func handle_event(event):
	match event:
		host.IDLE:
			print("AttackState: handle_event() -> IDLE")
			return host.IdleState
		host.MOVE:
			print("AttackState: handle_event() -> WALK")
			return host.WalkState
		host.FOLLOW:
			print("AttackState: handle_event() -> FOLLOW")
			return host.FollowState
		host.CHASE:
			print("AttackState: handle_event() -> CHASE")
			return host.ChaseState
		_:
			return null


func enter():
	print("AttackState: enter()")
	vec_to_move_position = host.target.position - host.position
	if vec_to_move_position.length() > host.stats.attack_radius:
		host.append_state(host.ChaseState)
		return


func update(delta):
	if host.target.stats.health <= 0:
		return true
	
	vec_to_move_position = host.target.position - host.position
	
	if vec_to_move_position.length() > host.stats.attack_radius:
		host.move_position = host.target.position
		host.append_state(host.ChaseState)
	
	if not attacked and host.Anim.current_animation != "attack":
		host.Anim.set_speed_scale(host.stats.attack_speed)
		host.Anim.play("attack")
		attacked = true
	
	if not host.Anim.is_playing() and host.Anim.assigned_animation == "attack":
		host.target.stats.health -= host.stats.damage
		print("[%s] attacked [%s] for %d damage" % [host.name, host.target.name, host.stats.damage])
		attacked = false
	
	return false


func exit():
	print("AttackState: exit()")
	attacked = false
	host.Anim.set_speed_scale(1.0)
	if host.Anim.is_playing():
		host.Anim.stop()
		host.Anim.play("INIT")
