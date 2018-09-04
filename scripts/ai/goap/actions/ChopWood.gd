extends "res://scripts/ai/goap/GoapAction.gd"


func _ready():
	preconditions.tired = false
	preconditions.has_axe = true
	effects.has_wood_to_create_axe = true
	effects.has_wood_to_create_pickaxe = true
	effects.has_wood_to_create_weapon = true


func reset():
	pass


func is_done():
	return action_done


func requires_in_range():
	return true


func check_procedural_precondition(character):
	var mining_resources = get_tree().get_nodes_in_group("wood_resource")
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
	
	if target != null:
		var io = target.interact.get_interact_object(character, "chop_tree")
		if io != null:
			cost = 20 - io.products.resources.wood
	
	return closest != null


func enter(character):
	interact_object = target.interact.get_interact_object(character, "chop_tree")
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
		target.perform_action(character, interact_object)
		print("Resources Chopped! [{0}]".format([interact_object.products]))
		print("Character Resources! [{0}]".format([character.backpack.resources]))
		action_done = true
		emit_signal("action_finished", { msg = "Wood Chopped!" })
