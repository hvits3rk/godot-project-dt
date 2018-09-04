extends Node

# Тут будут храниться ресурсы
var resources = {
	ore = {
		count = 0
	},
	wood = {
		count = 0
	}
}

# Экиперовка
var equipment = {
	weapons = [],
	armors = [],
	accessories = []
}

# Квестовые предметы
var quest_items = {}


func get_weapon_by_id(id):
	assert(id != null)
	
	for weapon in equipment.weapons:
		if weapon.id == id:
			return weapon
	
	return null


func get_armor_by_id(id):
	assert(id != null)
	
	for armor in equipment.armors:
		if armor.id == id:
			return armor
	
	return null


func get_accessory_by_id(id):
	assert(id != null)
	
	for accessory in equipment.accessories:
		if accessory.id == id:
			return accessory
	
	return null


func get_equipment_by_id(id):
	assert(id != null)
	
	var equip = get_weapon_by_id(id)
	if equip != null:
		return equip
	
	equip = get_armor_by_id(id)
	if equip != null:
		return equip
	
	equip = get_accessory_by_id(id)
	if equip != null:
		return equip
	
	return equip


func delete_weapon_by_id(id):
	assert(id != null)
	
	for weapon in equipment.weapons:
		if weapon.id == id:
			var backup = weapon.duplicate()
			equipment.weapons.erase(weapon)
			return backup
	
	return null


func delete_armor_by_id(id):
	assert(id != null)
	
	for armor in equipment.armors:
		if armor.id == id:
			var backup = armor.duplicate()
			equipment.armors.erase(armor)
			return backup
	
	return null


func delete_accessory_by_id(id):
	assert(id != null)
	
	for accessory in equipment.accessories:
		if accessory.id == id:
			var backup = accessory.duplicate()
			equipment.accessories.erase(accessory)
			return backup
	
	return null


func delete_equipment_by_id(id):
	assert(id != null)
	
	var equip = delete_weapon_by_id(id)
	if equip != null:
		return equip
	
	return equip


func get_weapons_by_types(types):
	assert(types != null)
	
	var typed_weapons = []
	for weapon in equipment.weapons:
		for type in types:
			if not type in weapon.types:
				break
			typed_weapons.append(weapon)
	
	return typed_weapons


func get_armors_by_types(types):
	assert(types != null)
	
	var typed_armors = []
	for armor in equipment.armors:
		for type in types:
			if not type in armor.types:
				break
			typed_armors.append(armor)
	
	return typed_armors


func get_accessories_by_types(types):
	assert(types != null)
	
	var typed_accessories = []
	for accessory in equipment.accessories:
		for type in types:
			if not type in accessory.types:
				break
			typed_accessories.append(accessory)
	
	return typed_accessories

# obj - dict с предметами, которые нужно добавить в инвентарь
#obj = {
#	resources = {
#		ore = 1,
#		wood = 1
#	},
#	equipment = {
#		weapons = [
#			{
#				id = "",
#				types = [ "weapon", "melee", "knuckle" ],
#				icon = "res://icon.png",
#				texture = "res://icon.png",
#				scene = "res://scenes/object/item/equipment/tool/Pickaxe.tscn",
#				attributes = {
#					item_name = "fists",
#					durability = 100.0,
#					resistance = 1000000.0
#				}
#			}
#		],
#		armors = [
#			{
#				id = "",
#				types = [ "armor", "head", "helmet" ],
#				icon = "",
#				texture = "",
#				scene = "",
#				attributes = {
#					item_name = "iron helmet",
#					durability = 100.0,
#					resistance = 1.0
#				}
#			}
#		],
#		accessories = [
#			{
#				id = "",
#				types = [ "accessory", "neck" ],
#				icon = "",
#				texture = "",
#				scene = "",
#				attributes = {
#					item_name = "golden necklace",
#					durability = 100.0,
#					resistance = 100.0
#				}
#			}
#		]
#	},
#	quest_items = {
#		quest_id = [
#			{
#				id = "",
#				types = [ "quest_item" ],
#				icon = "",
#				texture = "",
#				scene = "",
#				count = 1,
#				attributes = {
#					item_name = "golden apple",
#					durability = 100.0,
#					resistance = 100.0,
#				}
#			}
#		]
#	}
#}
func add_items(obj):
	if obj == null:
		return
	
	if obj.has("resources"):
		add_resources(obj.resources)
	
	if obj.has("equipment"):
		add_equipment(obj.equipment)
	
	if obj.has("quest_items"):
		add_quest_items(obj.quest_items)


func add_products(obj):
	add_items(obj)

# res - dict с ресурсами
#res = {
#	ore = 1,
#	wood = 1
#}
func add_resources(res):
	for key in res:
		if not resources.has(key):
			resources[key] = {}
		
		resources[key].count += res[key]


# obj - dict с экиперовкой
#equipment = {
#	weapons = [
#		{
#			id = "",
#			types = [ "weapon", "melee", "knuckle" ],
#			icon = "res://icon.png",
#			texture = "res://icon.png",
#			scene = "res://scenes/object/item/equipment/tool/Pickaxe.tscn",
#			attributes = {
#				item_name = "fists",
#				durability = 100.0,
#				resistance = 1000000.0
#			}
#		}
#	],
#	armors = [
#		{
#			id = "",
#			types = [ "armor", "head", "helmet" ],
#			icon = "",
#			texture = "",
#			scene = "",
#			attributes = {
#				item_name = "iron helmet",
#				durability = 100.0,
#				resistance = 1.0
#			}
#		}
#	],
#	accessories = [
#		{
#			id = "",
#			types = [ "accessory", "neck" ],
#			icon = "",
#			texture = "",
#			scene = "",
#			attributes = {
#				item_name = "golden necklace",
#				durability = 100.0,
#				resistance = 100.0
#			}
#		}
#	]
#}
func add_equipment(obj):
	if obj.has("weapons"):
		add_weapons(obj.weapons)
	
	if obj.has("armors"):
		add_armors(obj.armors)
	
	if obj.has("accessories"):
		add_accessories(obj.accessories)


# weapons - array
#weapons = [
#	{
#		id = "",
#		types = [ "weapon", "melee", "knuckle" ],
#		icon = "res://icon.png",
#		texture = "res://icon.png",
#		scene = "res://scenes/object/item/equipment/tool/Pickaxe.tscn",
#		attributes = {
#			item_name = "fists",
#			durability = 100.0,
#			resistance = 1000000.0
#		}
#	}
#]
func add_weapons(weapons):
	for weapon in weapons:
		add_weapon(weapon)


func add_weapon(weapon):
	equipment.weapons.append(weapon)


# armors = array
#armors = [
#	{
#		id = "",
#		types = [ "armor", "head", "helmet" ],
#		icon = "",
#		texture = "",
#		scene = "",
#		attributes = {
#			item_name = "iron helmet",
#			durability = 100.0,
#			resistance = 1.0
#		}
#	}
#]
func add_armors(armors):
	for armor in armors:
		add_armor(armor)


func add_armor(armor):
	equipment.armors.append(armor)


# accessories - array
#accessories = [
#	{
#		id = "",
#		types = [ "accessory", "neck" ],
#		icon = "",
#		texture = "",
#		scene = "",
#		attributes = {
#			item_name = "golden necklace",
#			durability = 100.0,
#			resistance = 100.0
#		}
#	}
#]
func add_accessories(accessories):
	for accessory in accessories:
		add_accessory(accessory)


func add_accessory(accessory):
	equipment.accessories.append(accessory)


# items - dict
#items = {
#	quest_id = [
#		{
#			id = "",
#			types = [ "quest_item" ],
#			icon = "",
#			texture = "",
#			scene = "",
#			count = 1,
#			attributes = {
#				item_name = "golden apple",
#				durability = 100.0,
#				resistance = 100.0,
#			}
#		}
#	]
#}
func add_quest_items(items):
	for quest_id in items:
		add_quest_item(quest_id, items.quest_id)


func add_quest_item(quest_id, items):
	if not quest_items.has(quest_id):
		quest_items[quest_id] = []
		
	for item in items:
		quest_items[quest_id].append(item)


func has_resource(name, amount=1):
	if resources.has(name):
		if resources[name].count >= amount:
			return true
	
	return false
