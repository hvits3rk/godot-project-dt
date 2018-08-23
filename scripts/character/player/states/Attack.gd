extends "res://scripts/character/player/states/StateBase.gd"

var vec_to_move_position = Vector2()
var attacking = false

onready var anim = get_parent().get_parent().get_node("AnimationPlayer")


func _ready():
	anim.connect("animation_finished", self, "_on_attack_animation_finished")
	anim.connect("animation_started", self, "_on_attack_animation_started")


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
	attacking = false


func update(delta):
#	if host.target.stats.health <= 0:
#		return true
	
	vec_to_move_position = host.target.position - host.position
	
	if not attacking and vec_to_move_position.length() > host.stats.attack_radius:
		host.move_position = host.target.position
		host.append_state(host.ChaseState)
	
	if not attacking and anim.current_animation != "attack":
		anim.play("attack", -1, host.stats.attack_speed)
		attacking = true
	
	return false


func exit():
	print("AttackState: exit()")
	anim.set_speed_scale(1.0)
	attacking = false


func _on_attack_animation_started(anim_name):
	if not attacking and anim_name != "attack":
		host.look_at_position(host.target.position)
		print("attack_started")
		attacking = true


func _on_attack_animation_finished(anim_name):
	if attacking and anim_name == "attack":
		print("attack_finished")
		host.target.stats.health -= host.stats.damage
		print("[%s] attacked [%s] for %d damage" % [host.name, host.target.name, host.stats.damage])
		attacking = false