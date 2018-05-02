extends VBoxContainer

var ItemType = preload("res://scripts/forge/common/enum/ItemType.gd")

onready var ItemInfoContainer = get_node("ItemInfoContainer")
onready var ItemTypeContainer = get_node("ItemTypeContainer")
onready var WeaponTypeContainer = get_node("WeaponTypeContainer")
onready var ArmorTypeContainer = get_node("ArmorTypeContainer")

func _ready():
	ItemInfoContainer.connect("item_info_entered", self, "_on_ItemInfoContainer_item_info_entered")
	ItemTypeContainer.connect("item_type_selected", self, "_on_ItemTypeContainer_item_type_selected")
	WeaponTypeContainer.connect("weapon_type_selected", self, "_on_WeaponTypeContainer_weapon_type_selected")
	ArmorTypeContainer.connect("armor_type_selected", self, "_on_ArmorTypeContainer_armor_type_selected")

func _on_ItemInfoContainer_item_info_entered(item_info):
	pass

func _on_ItemTypeContainer_item_type_selected(item_type):
	match item_type:
		ItemType.WEAPON:
			WeaponTypeContainer.visible = true
			ArmorTypeContainer.visible = false
		ItemType.ARMOR:
			WeaponTypeContainer.visible = false
			ArmorTypeContainer.visible = true

func _on_WeaponTypeContainer_weapon_type_selected(weapon_type):
	pass

func _on_ArmorTypeContainer_armor_type_selected(armor_type):
	pass