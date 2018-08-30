extends Node

# Абстрактный класс для действий (action)

signal action_finished(object)

export (float, 0.0, 300.0, 0.1) var action_duration = 2.0

var preconditions = {}
var effects = {}
var in_range = false
var action_done = false
var timer = 0.0

# Цена совершения дейсвия
var cost = 1.0

# Цель действия
var target


# Сбрасываем состояние действия. Эту вызываем при сбросе.
func do_reset():
	in_range = false
	action_done = false
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


# Выполняем дейсвие
func perform(character, delta):
	return false


# Нужно ли быть на определенном расстоянии
func requires_in_range():
	return false


# На нужном ли мы расстоянии
func is_in_range():
	return in_range
