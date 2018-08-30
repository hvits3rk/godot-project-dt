extends Node

# Базовый класс для агента, это абстрактный класс

onready var character = get_parent()
onready var backpack = character.get_node("Backpack")

var velocity = Vector2()
var position_to_move = Vector2()
var black_board = {} setget add_world_state, get_world_state
var goal = {} setget set_goal, get_goal


# Возвращает состояние мира агента
func get_world_state():
	black_board.tired = character.stats.stamina < 20.0
	black_board.good_health = character.stats.health > 20.0
	
	return black_board


# Добавить состояние
func add_world_state(state):
	black_board[state.key] = black_board[state.value]


# Удалить состояние
func remove_world_state(key):
	if black_board.has(key):
		black_board.erase(key)


# Получить цель
func get_goal():
	return goal


# Установить цель
func set_goal(new_goal):
	goal = new_goal


# План провалился
func plan_failed(failed_goal):
	print("Plan Failed! Failed Goal: " + str(failed_goal))


# Найден план
func plan_found(goal, plan):
	_pretty_print(goal, plan)


# План завершен
func plan_finished():
	print("Plan Finished!")


# План отменен
func plan_aborted(aborter_action):
	print("Plan aborted! Aborter action: {0}".format([aborter_action.name]))


# Вывод плана в лог
func _pretty_print(goal, plan):
	var cost = 0
	var string = "Goal: " + str(goal) + " => "
	for action in plan:
		cost += action.cost
		string += action.name + " -> "
	string += "Cost: " + str(cost)
	print("****** PLAN FOUND ******")
	print(string)
	print("************************")
