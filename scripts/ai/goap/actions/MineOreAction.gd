extends "res://scripts/ai/goap/GoapAction.gd"


func _ready():
	preconditions.tired = false
	preconditions.has_pickaxe = true
	effects.has_ore_to_create_axe = true
	effects.has_ore_to_create_pickaxe = true
	effects.has_ore_to_create_weapon = true

func reset():
	pass


func is_done():
	return action_done


func requires_in_range():
	return true


func check_procedural_precondition(character):
	var mining_resources = get_tree().get_nodes_in_group("ore_resource")
	var closest = null
	var closest_dist = 0
	
	for res in mining_resources:
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
		character.backpack.items.num_ore += 3
		#character.stats.decrease_stamina(20)
		action_done = true
		emit_signal("action_finished", { msg = "Ore Mined!" })
		print("Ore Mined! [{0}]".format([character.backpack.items.num_ore]))
		character.backpack.items.pickaxe.health -= 0.5
		if character.backpack.items.pickaxe.health <= 0:
			character.backpack.items.pickaxe = null
			print("Pickaxe Broken!")
			return false
	
	timer += delta
	
	return true
