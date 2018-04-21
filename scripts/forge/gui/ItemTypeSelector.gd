extends HBoxContainer

signal item_type_chosen

onready var WeaponButton = get_node("Weapon")
onready var ArmorButton = get_node("Armor")

const ItemType = preload("res://scripts/forge/common/enum/ItemType.gd")

func _ready():
	WeaponButton.connect("pressed", self, "_on_WeaponButton_pressed")
	ArmorButton.connect("pressed", self, "_on_ArmorButton_pressed")

func _on_WeaponButton_pressed():
	emit_signal("item_type_chosen", ItemType.WEAPON)

func _on_ArmorButton_pressed():
	emit_signal("item_type_chosen", ItemType.ARMOR)