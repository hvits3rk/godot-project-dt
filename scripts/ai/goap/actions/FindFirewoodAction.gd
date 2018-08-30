extends "res://scripts/ai/goap/GoapAction.gd"


func _ready():
	preconditions.tired = false
	effects.has_firewood_to_create_axe = true
	effects.has_firewood_to_create_pickaxe = true
	effects.has_firewood_to_create_weapon = true
	cost = 20.0


func reset():
	pass


func is_done():
	return action_done


func requires_in_range():
	return true


func check_procedural_precondition(character):
	var firewood_resources = get_tree().get_nodes_in_group("log_resource")
	var closest = null
	var closest_dist = 0
	
	for res in firewood_resources:
		if closest == null:
			closest = res
			closest_dist = (res.position - character.position).length()
		else:
			var dist = (res.position - character.position).length()
			if dist < closest_dist:
				closest = res
				closest_dist = dist
	
	target = closest
	
	return closest != null


func perform(character, delta):
	if timer >= action_duration:
		character.backpack.items.num_firewood += 1
		#character.stats.decrease_stamina(20)
		action_done = true
		emit_signal("action_finished", { msg = "Firewood Found!" })
		print("Firewood Found! [{0}]".format([character.backpack.items.num_firewood]))
	
	timer += delta
	
	return true
