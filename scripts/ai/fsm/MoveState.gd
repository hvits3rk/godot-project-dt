extends "res://scripts/ai/fsm/BaseState.gd"

# Время ожидания для перерасчета пути
export (float, 0.1, 60, 0.1) var delay_time = 0.1

var velocity = Vector2()
var position_to_move = Vector2()
var timer = 0
var action = null
var at_position = false

func _ready():
	interactable_area.connect("body_entered", self, "_on_body_entered")


func enter():
	velocity.x = 0
	velocity.y = 0
	timer = 0
	action = agent.current_actions.front()
	if action != null:
		var overlapping_bodies = interactable_area.get_overlapping_bodies()
		at_position = overlapping_bodies.has(action.target)
	anim.get_animation("walk").loop = true
	anim.play("walk", 0.1)


func update(delta):
	
	# Находим вектор до цели
	position_to_move = action.target.position - character.position
	
	timer -= delta
	
	# Перерасчитываем вектор движения к цели
	if timer <= 0:
		timer = delay_time
		velocity = position_to_move.normalized() * character.stats.move_speed
		character.look_at_position(action.target.position)
	
	# Если дошли до цели, можно выходить из состояния движения
	if at_position or position_to_move.length() < 5:
		action.in_range = true
		return true
	
	# Двигаемся к цели
	character.move_and_slide(velocity)
	
	return false


func exit():
	action = null
	at_position = false
	anim.get_animation("walk").loop = false


func _on_body_entered(body):
	if action != null and body == action.target:
		at_position = true

