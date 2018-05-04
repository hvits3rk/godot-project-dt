extends GridContainer

signal item_type_selected

const ItemType = preload("res://scripts/forge/common/enum/ItemType.gd")

onready var WeaponButton = find_node("WeaponButton")
onready var ArmorButton = find_node("ArmorButton")

var button_group
var pressed_button

func _ready():
	button_group = ButtonGroup.new()
	WeaponButton.connect("toggled", self, "_on_ItemTypeButton_toggled")
	ArmorButton.connect("toggled", self, "_on_ItemTypeButton_toggled")
	ArmorButton.meta.type = ItemType.ARMOR
	WeaponButton.meta.type = ItemType.WEAPON
	WeaponButton.group = button_group
	ArmorButton.group = button_group

func clear_input():
	if pressed_button:
		pressed_button.pressed = false

func _on_ItemTypeButton_toggled(button_pressed):
	pressed_button = button_group.get_pressed_button()
	emit_signal("item_type_selected", pressed_button.meta.type)