extends "res://scripts/character/player/states/StateBase.gd"

var state_name = "attack"

var position_to_move = Vector2()
var attacking = false


func _ready():
	anim.connect("animation_finished", self, "_on_attack_animation_finished")
	anim.connect("animation_started", self, "_on_attack_animation_started")


func handle_event(event):
	match event:
		host.MOVE:
			print("AttackState: handle_event() -> WALK")
			return { append = false, state = host.walk_state }
		host.CHASE:
			print("AttackState: handle_event() -> CHASE")
			return { append = false, state = host.chase_state }
		_:
			return null


func enter():
	print("AttackState: enter()")
	attacking = false


func update(delta):
	if not host.target:
		return true
	
#	if host.target.stats.health <= 0:
#		host.target = null
#		return true
	
	position_to_move = host.target.position - host.position
	
	if not attacking and position_to_move.length() > host.stats.attack_radius:
		host.move_position = host.target.position
		host.append_state(host.chase_state)
	
	if not attacking and anim.current_animation != "attack":
		anim.play("attack", 0.1, host.stats.attack_speed)
		attacking = true
	
	return false


func exit():
	print("AttackState: exit()")
	anim.set_speed_scale(1.0)
	attacking = false


func _on_attack_animation_started(anim_name):
	if not host.target:
		return
	
	if not attacking and anim_name != "attack":
		host.look_at_position(host.target.position)
		attacking = true


func _on_attack_animation_finished(anim_name):
	if attacking and anim_name == "attack":
		host.target.stats.health -= host.stats.damage
		print("[%s] attacked [%s] for %d damage" % [host.name, host.target.name, host.stats.damage])
		attacking = false