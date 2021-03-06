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


func enter(character):
	interact_object = target.interact.get_interact_object(character, "mine")
	if interact_object == null:
		return false
	
	return true


func perform(character, delta):
	if not action_done and anim.current_animation != interact_object.animation:
		anim.play(interact_object.animation, 0.1)
	
	return true


func _on_action_animation_started(anim_name):
	if interact_object == null:
		return
	
	if anim_name == interact_object.animation:
		pass

func _on_action_animation_finished(anim_name):
	if interact_object == null:
		return
	
	if anim_name == interact_object.animation:
		target.interact.perform_action(character, interact_object)
		print("Resources Mined! [{0}]".format([interact_object.products]))
		print("Character Resources! [{0}]".format([character.backpack.resources]))
		action_done = true
		emit_signal("action_finished", { msg = "Ore Mined!" })
