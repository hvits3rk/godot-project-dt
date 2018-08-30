extends "res://scripts/ai/fsm/BaseState.gd"

var action = null


func enter():
	if agent.has_action_plan():
		action = agent.current_actions.front()
	# anim.play(action.animation, 0.1)


func update(delta):
	# Нет плана? Возвращаемся к планированию (idle_state)
	if not agent.has_action_plan():
		data_provider.plan_finished()
		agent.append_state(agent.idle_state)
		return false
	
	# Берем первое в списке действие
	action = agent.current_actions.front()
	
	if action.is_done():
		# Если дейсвие закончено, проверяем состояние следующего
		if agent.current_actions.size() > 1:
			var next_action = agent.current_actions[1]
			if not agent.planner.in_state(next_action.preconditions,
					data_provider.get_world_state()):
				
				# Следующее дейсвие не совершить, идем планировать
				data_provider.plan_failed(data_provider.get_goal())
				data_provider.plan_aborted(next_action)
				agent.append_state(agent.idle_state)
				return false
		
		# С планом, пока что, все в порядке, идем по списку дальше
		agent.current_actions.pop_front()
	
	# Если действия в плане еще остались
	if agent.has_action_plan():
		# Берем следующее
		action = agent.current_actions.front()
		
		# Проверяем нужно ли подходить, чтобы выполнить дейсвие
		var in_range = action.is_in_range() if action.requires_in_range() else true
		
		if in_range:
			# Совершаем дейсвие
			if not action.perform(character, delta):
				# Дейсвие провалилось, идем планировать
				data_provider.plan_failed(data_provider.get_goal())
				data_provider.plan_aborted(action)
				agent.append_state(agent.idle_state)
				return false
		else:
			# Нужно подойти к цели дейсвия
			agent.append_state(agent.move_state)
		
	else:
		# План закончился, идем планировать
		data_provider.plan_finished()
		agent.append_state(agent.idle_state)
		return false
	
	return false


func exit():
	action = null
