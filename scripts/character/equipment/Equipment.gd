extends Position2D

onready var backpack = get_node("Backpack")
onready var tools = get_node("Tools")
onready var weapon = get_node("Weapon")
onready var helmet = get_node("Head/Helmet")
onready var armor = get_node("Armor")

var _axe = null setget equip_axe, get_axe
var _wr_axe
var _pickaxe = null setget equip_pickaxe, get_pickaxe
var _wr_pickaxe
var _hammer = null setget equip_hammer, get_hammer
var _wr_hammer
var _weapon = null setget equip_weapon, get_weapon
var _wr_weapon
#var _helmet = null setget equip_helmet, get_helmet
#var _armor = null setget equip_armor, get_armor


func equip_item(obj):
	var types = obj.types
	
	if types.has("axe"):
		equip_axe(obj)
	
	if types.has("pickaxe"):
		equip_pickaxe(obj)
	
	if types.has("weapon"):
		equip_weapon(obj)


func get_axe():
	return _axe


func get_pickaxe():
	return _pickaxe


func get_hammer():
	return _hammer


func get_weapon():
#	if _weapon == null:
#		var bare_heands = {
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
#		equip_weapon(bare_heands)
#		_weapon.sprite.texture = null
	
	return _weapon


func get_equipment(name):
	match name:
		"axe":
			return _axe
		"pickaxe":
			return _pickaxe
		"weapon":
			return _weapon
		"hammer":
			return _hammer


func check_axe():
	if _axe != null and _wr_axe.get_ref():
		return true
	
	return false


func check_pickaxe():
	if _pickaxe != null and _wr_pickaxe.get_ref():
		return true
	
	return false


func use(equip_name, amount):
	var equip = get_equipment(equip_name)
	
	equip.use(amount)
	
	if equip.durability <= 0:
		backpack.delete_equipment_by_id(equip.id)
		equip.queue_free()


func check_durability():
	pass


func has_needed_tools(array):
	for tool_name in array:
		match tool_name:
			"axe":
				if _axe == null:
					return false
			"pickaxe":
				if _pickaxe == null:
					return false
	
	return true


func equip_axe(obj):
	var node = _instance_base_equipment_node(tools, obj)
	
	_axe = node
	_wr_axe = weakref(_axe)


func equip_pickaxe(obj):
	var node = _instance_base_equipment_node(tools, obj)
	
	_pickaxe = node
	_wr_pickaxe = weakref(_pickaxe)


func equip_weapon(obj):
	var node = _instance_base_equipment_node(weapon, obj)
	
	_weapon = node
	_wr_weapon = weakref(_weapon)


func equip_hammer(obj):
	var node = _instance_base_equipment_node(tools, obj)
	
	_hammer = node
	_wr_hammer = weakref(_hammer)


func _instance_base_equipment_node(parent, obj):
	var scene = load(obj.scene)
	var texture = load(obj.texture)
	var node = scene.instance()
	parent.add_child(node)
	node.id = obj.id
	node.item_name = obj.attributes.item_name
	node.durability_max = obj.attributes.durability
	node.durability = obj.attributes.durability
	node.resistance = obj.attributes.resistance
	node.sprite.texture = texture
	
	return node