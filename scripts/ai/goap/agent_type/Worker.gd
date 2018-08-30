extends "res://scripts/ai/goap/agent_type/BaseAgent.gd"


func get_world_state():
	var world_state = .get_world_state()
	var items = backpack.items
	
	world_state.has_logs = items.num_logs > 0
	world_state.has_pickaxe = items.pickaxe != null
	world_state.has_axe = items.axe != null
	world_state.has_firewood_to_create_axe = items.num_firewood >= 3
	world_state.has_firewood_to_create_pickaxe = items.num_firewood >= 3
	world_state.has_firewood_to_create_weapon = items.num_firewood >= 5
	world_state.has_ore_to_create_axe = items.num_ore >= 1
	world_state.has_ore_to_create_pickaxe = items.num_ore >= 1
	world_state.has_ore_to_create_weapon = items.num_ore >= 2
	
	return world_state


func get_goal():
	goal.create_weapon = true
	return goal