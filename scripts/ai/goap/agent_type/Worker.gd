extends "res://scripts/ai/goap/agent_type/BaseAgent.gd"


func get_world_state():
	var world_state = .get_world_state()
	var resources = backpack.resources
	
	world_state.has_wood = backpack.has_resource("wood")
	world_state.has_pickaxe = equipment.check_pickaxe()
	world_state.has_axe = equipment.check_axe()
	world_state.has_wood_to_create_axe = backpack.has_resource("wood", 3)
	world_state.has_wood_to_create_pickaxe = backpack.has_resource("wood", 3)
	world_state.has_wood_to_create_weapon = backpack.has_resource("wood", 5)
	world_state.has_ore_to_create_axe = backpack.has_resource("ore", 1)
	world_state.has_ore_to_create_pickaxe = backpack.has_resource("ore", 1)
	world_state.has_ore_to_create_weapon = backpack.has_resource("ore", 3)
	
	return world_state


func get_goal():
	goal.create_weapon = true
	return goal