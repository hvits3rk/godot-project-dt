extends "res://scripts/ai/goap/GoapAction.gd"


func _ready():
	preconditions.tired = false
	preconditions.has_pickaxe = true
	#preconditions.has_axe = true
	preconditions.has_firewood_to_create_weapon = true
	preconditions.has_ore_to_create_weapon = true
	effects.create_weapon = true


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


func perform(character, delta):
	if timer >= action_duration:
		character.backpack.items.num_ore -= 2
		character.backpack.items.num_firewood -= 5
		#character.stats.decrease_stamina(20)
		action_done = true
		emit_signal("action_finished", { msg = "Weapon Created!" })
		print("Weapon Created!")
	
	timer += delta
	
	return true
