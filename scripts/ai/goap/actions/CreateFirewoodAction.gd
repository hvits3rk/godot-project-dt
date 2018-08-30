extends "res://scripts/ai/goap/GoapAction.gd"


func _ready():
	preconditions.tired = false
	preconditions.has_logs = true
	preconditions.has_axe = true
	effects.has_firewood_to_create_axe = true
	effects.has_firewood_to_create_pickaxe = true
	effects.has_firewood_to_create_weapon = true


func reset():
	pass


func is_done():
	return action_done


func perform(character, delta):
	if timer >= action_duration:
		character.backpack.items.num_logs -= 1
		character.backpack.items.num_firewood += 5
		#character.stats.decrease_stamina(20)
		character.backpack.items.axe.health -= 0.5
		action_done = true
		emit_signal("action_finished", { msg = "Firewood Created!" })
		print("Firewood Created! [{0}]".format([character.backpack.items.num_firewood]))
	
	timer += delta
	
	return true
