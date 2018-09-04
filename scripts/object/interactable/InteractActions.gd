extends Node

signal resources_check_failed(resources_needed)
signal equipment_check_failed(equipment_needed)

var actions = {
	kick = {
		animation = "kick",
		resources = null,
		equipment = null,
		products = null
	}
}


func perform_action(character, interact_obj):
	if interact_obj == null:
		return null
	
	if interact_obj.resources != null:
		for res in interact_obj.resources:
			character.backpack.resources[res].count -= interact_obj.resources[res]
	
	if interact_obj.equipment != null and interact_obj.equipment.size() > 0:
		for equip_name in interact_obj.equipment:
			character.equipment.use(equip_name, 25)
	
	if interact_obj.products != null and interact_obj.products.has("equipment"):
		generate_uuid_for_all(interact_obj.products.equipment)
	
	character.backpack.add_products(interact_obj.products)
	
	return true


func get_interact_object(character, action_name="kick"):
	if not actions.has(action_name):
		printerr("NO SUCH ACTION: " + action_name)
		return null
	
	var have_resources = check_resources(character, action_name)
	var have_equipment = check_equipment(character, action_name)
	
	if have_resources and have_equipment:
		return actions[action_name]
	
	return null


func check_resources(character, action_name):
	var char_resources = character.backpack.resources
	var resources = actions[action_name].resources
	
	if resources == null or resources.keys().size() == 0:
		return true
	
	if char_resources.has_all(resources.keys()):
		for key in resources:
			if char_resources[key] == null or char_resources[key].count < resources[key]:
				emit_signal("resources_check_failed", resources)
				return false
	
	return true


func check_equipment(character, action_name):
	var char_equipment = character.equipment
	var equipment = actions[action_name].equipment
	
	if equipment == null or equipment.size() == 0:
		return true
	
	if not char_equipment.has_needed_tools(equipment):
		emit_signal("equipment_check_failed", equipment)
		return false
	
	return true


func generate_uuid_for_all(equipment):
	if equipment.has("weapons") and equipment.weapons.size() > 0:
		generate_uuid(equipment.weapons)
	
	if equipment.has("armors") and equipment.armors.size() > 0:
		enerate_uuid(equipment.armors)
		
	if equipment.has("accessories") and equipment.accessories.size() > 0:
		enerate_uuid(equipment.accessories)


func generate_uuid(equipment):
	for equip in equipment:
		equip.time = OS.get_datetime(true)
		var id = str(equip.hash()).sha256_text()
		equip.id = id
		equip.erase("time")