extends HBoxContainer

signal item_info_prepaired

const ItemType = preload("res://scripts/forge/common/enum/ItemType.gd")
const WeaponType = preload("res://scripts/forge/common/enum/WeaponType.gd")
const ArmorType = preload("res://scripts/forge/common/enum/ArmorType.gd")

onready var ItemInfoContainer = get_node("ItemInfoContainer")
onready var ItemTypeContainer = get_node("VBoxContainer/ItemTypeContainer")
onready var WeaponTypeContainer = get_node("VBoxContainer/WeaponTypeContainer")
onready var ArmorTypeContainer = get_node("VBoxContainer/ArmorTypeContainer")

# item_name : String
# item_description : String
# type : ItemType.gd
# weapon_type : WeaponType.gd
# armor_type : ArmorType.gd

var formed_item = {}

func _ready():
	ItemInfoContainer.connect("item_info_entered", self, "_on_ItemInfoContainer_item_info_entered")
	ItemTypeContainer.connect("item_type_selected", self, "_on_ItemTypeContainer_item_type_selected")
	WeaponTypeContainer.connect("weapon_type_selected", self, "_on_WeaponTypeContainer_weapon_type_selected")
	ArmorTypeContainer.connect("armor_type_selected", self, "_on_ArmorTypeContainer_armor_type_selected")

func _validate_item_data():
	match formed_item:
		{ "item_name", "type", ..}:
			if formed_item.has("weapon_type") or formed_item.has("armor_type"):
				if !formed_item.item_name.empty():
					emit_signal("item_info_prepaired", formed_item)
					return
			emit_signal("item_info_prepaired", null)

func _on_ItemInfoContainer_item_info_entered(item_info):
	formed_item.item_name = item_info.name
	formed_item.item_description = item_info.description
	_validate_item_data()

func _on_ItemTypeContainer_item_type_selected(item_type):
	match item_type:
		ItemType.WEAPON:
			WeaponTypeContainer.visible = true
			ArmorTypeContainer.visible = false
			ArmorTypeContainer.clear_input()
			if formed_item.has("armor_type"):
				formed_item.erase("armor_type")
		ItemType.ARMOR:
			WeaponTypeContainer.visible = false
			ArmorTypeContainer.visible = true
			WeaponTypeContainer.clear_input()
			if formed_item.has("weapon_type"):
				formed_item.erase("weapon_type")
	formed_item.type = item_type
	_validate_item_data()

func _on_WeaponTypeContainer_weapon_type_selected(weapon_type):
	if formed_item.type == ItemType.WEAPON:
		formed_item.weapon_type = weapon_type
	_validate_item_data()

func _on_ArmorTypeContainer_armor_type_selected(armor_type):
	if formed_item.type == ItemType.ARMOR:
		formed_item.armor_type = armor_type
	_validate_item_data()
