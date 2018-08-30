extends "res://scripts/ai/fsm/BaseState.gd"

# Время ожидания для построения нового плана
export (float, 0.1, 60, 0.1) var delay_time = 2.0

var timer = 0.0


# Перед входом в это состояние
func enter():
	anim.get_animation("idle").loop = true
	anim.queue("idle")


# Вызываем на каждом фрейме
func update(delta):
	
	# Пока персонаж в состоянии спокойствия, востонавливаем усталость
	character.stats.restore_stamina(delta * 5)
	
	# Отсчитываем время
	if timer >= 0:
		timer -= delta
		return false
	
	# Получаем текущее состояние мира, и цель персонажа
	var world_state = data_provider.get_world_state()
	var goal = data_provider.get_goal()
	
	# Состовляем план
	agent.planner.plan(character, agent.available_actions, world_state, goal)
	var plan = yield(agent.planner, "plan_found")
	
	# Обновляем таймер
	timer = delay_time
	
	# Если план найден, переходим в состояние действия
	# нет, остаемся в состоянии спокойствия.
	if plan != null:
		# передаем план агенту
		agent.current_actions = plan
		data_provider.plan_found(goal, plan)
		
		return true
	else:
		data_provider.plan_failed(goal)
		
		return false
	
	return false


# Перед выходом из состояния
func exit():
	anim.get_animation("idle").loop = false
