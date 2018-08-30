extends Node

# Этот класс отвечает за построение плана

signal plan_found(plan)


# Вспомогательный класс, для построения веток
class PlannerNode:
	var parent
	var running_cost
	var world_state
	var action
	
	func _init(parent, running_cost, world_state, action):
		self.parent = parent
		self.running_cost = running_cost
		self.world_state = world_state
		self.action = action


# Ищет цепочку дейсвий для выполнения задачи
func plan(character, available_actions, world_state, goal):
	# Ищем все действия которые доступны агенту и могут быть исполнены
	var usable_actions = []
	
	for action in available_actions:
		action.do_reset()
		
		if action.check_procedural_precondition(character):
			if not usable_actions.has(action):
				usable_actions.append(action)
	
	# Строим дерево из веток, которые могут привести к выполнению плана
	var branches = []
	
	# Строим граф
	var root_node = PlannerNode.new(null, 0, world_state, null)
	var success = build_graph(root_node, branches, usable_actions, goal)
	
	if not success:
		# Не нашли подходящего плана
		emit_signal("plan_found", null)
		return null
	
	# Находим самую дешевую ветку
	var cheapest = null
	for node in branches:
		if cheapest == null:
			cheapest = node
		else:
			if node.running_cost < cheapest.running_cost:
				cheapest = node
	
	# Пробегаемся по ветке, сохраняя последовательность дейсвий
	var result = []
	var node = cheapest;
	while node != null:
		if node.action != null:
			result.push_front(node.action)
		
		node = node.parent
	
	# получили список действий в нужном порядке
	emit_signal("plan_found", result)
	return result


# Рекурсивная функция поиска "пути". Строит ветки, ведущие к выполнению плана.
func build_graph(parent, branches, usable_actions, goal):
	var found = false
	# пробегаем по всем доступным действиям
	for action in usable_actions:
		# если родительское состояние мира обладает нужным состоянием,
		# для выполнения этого действия, то
		if in_state(action.preconditions, parent.world_state):
			# применить эффекты этого действия к состоянию родителя
			var current_state = populate_state(parent.world_state, action.effects)
			var node = PlannerNode.new(parent, parent.running_cost + action.cost, current_state, action)
			
			if in_state(goal, current_state):
				# если текущее состояние совпадает с задачей, мы построили успешную ветку
				branches.append(node)
				found = true
			else:
				# нет, берем оставшиеся дейсвия и строим ветку дальше
				var subset = action_subset(usable_actions, action)
				var branch_found = build_graph(node, branches, subset, goal)
				if branch_found:
					found = true
	
	return found


# возвращает список дейсвий, исключая один
func action_subset(actions, action_to_remove):
	var subset = []
	for action in actions:
		if not action == action_to_remove:
			subset.append(action)
	
	return subset


# проверяем, дейсвие может быть пыполнено в текущем состоянии мира.
func in_state(action_preconditions, world_state):
	if not world_state.has_all(action_preconditions.keys()):
		return false
	
	for key in action_preconditions:
		if action_preconditions[key] != world_state[key]:
			return false
	
	return true


# применяем еффекты дейсвия к миру.
func populate_state(current_world_state, action_effect):
	var new_world_state = current_world_state.duplicate()
	
	for key in action_effect:
		new_world_state[key] = action_effect[key]
	
	return new_world_state
