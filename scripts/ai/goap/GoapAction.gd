extends Node

# Абстрактный класс для действий (action)

signal action_finished(object)

export (float, 0.0, 300.0, 0.1) var action_duration = 2.0

var preconditions = {}
var effects = {}
var in_range = false
var action_done = false
var anim_finished = false
var timer = 0.0
var interact_object
var anim
var character

# Цена совершения дейсвия
var cost = 1.0

# Цель действия
var target


func _ready():
	character = owner
	anim = owner.get_node("AnimationPlayer")
	anim.connect("animation_started", self, "_on_action_animation_started")
	anim.connect("animation_finished", self, "_on_action_animation_finished")


# Сбрасываем состояние действия. Эту вызываем при сбросе.
func do_reset():
	anim_finished = false
	in_range = false
	action_done = false
	interact_object = null
	target = null
	timer = 0.0
	reset()


# Эту функцию имплементируем в классе наследника
func reset():
	pass


# Завершили дейсвие?
func is_done():
	return false


# Эта функция для проверки, можно ли запустить это дейсвие
func check_procedural_precondition(character):
	return true


# При начале действия
func enter(character):
	interact_object = target.interact.get_interact_object(character)
	character.anim.play(interact_object.animation)


# Выполняем дейсвие
func perform(character, delta):
	return true


# Нужно ли быть на определенном расстоянии
func requires_in_range():
	return false


# На нужном ли мы расстоянии
func is_in_range():
	return in_range


func _on_action_animation_started(anim_name):
	pass


func _on_action_animation_finished(anim_name):
	pass