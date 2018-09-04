extends "res://scripts/ai/goap/GoapAction.gd"


func _ready():
	preconditions.tired = false
	preconditions.has_wood_to_create_pickaxe = true
	preconditions.has_ore_to_create_pickaxe = true
	effects.has_pickaxe = true


func reset():
	pass


func is_done():
	return action_done


func requires_in_range():
	return true


func check_procedural_precondition(character):
	var forges = get_tree().get_nodes_in_group("forge")
	var closest = null
	var closest_dist = 0
	
	for forge in forges:
		if closest == null:
			closest = forge
			closest_dist = (forge.position - character.position).length()
		else:
			var dist = (forge.position - character.position).length()
			if dist < closest_dist:
				closest = forge
				closest_dist = dist
	
	target = closest
	
	return closest != null


func enter(character):
	interact_object = target.interact.get_interact_object(character, "create_pickaxe")
	if interact_object == null:
		return false
	
	return true


func perform(character, delta):
	if not action_done and anim.current_animation != interact_object.animation:
		anim.play(interact_object.animation, 0.1)
	
	if timer >= action_duration:
		target.interact.perform_action(character, interact_object)
		if not character.equipment.check_pickaxe():
			var pickaxes = character.backpack.get_weapons_by_types(["tools", "pickaxe"])
			assert(pickaxes.size() > 0)
			character.equipment.equip_pickaxe(pickaxes[0])
		print("Pickaxe Forged! [{0}]".format([interact_object.products]))
		print("Character Resources! [{0}]".format([character.backpack.resources]))
		action_done = true
		emit_signal("action_finished", { msg = "Pickaxe Created" })
	
	timer += delta
	
	return true
