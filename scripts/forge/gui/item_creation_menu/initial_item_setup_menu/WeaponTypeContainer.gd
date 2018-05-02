extends GridContainer

signal weapon_type_selected

const WeaponType = preload("res://scripts/forge/common/enum/WeaponType.gd")

onready var SwordButton = get_node("SwordButton")
onready var AxeButton = get_node("AxeButton")
onready var HammerButton = get_node("HammerButton")

var button_group
var pressed_button

func _ready():
	button_group = ButtonGroup.new()
	SwordButton.connect("toggled", self, "_on_WeaponTypeButton_toggled")
	AxeButton.connect("toggled", self, "_on_WeaponTypeButton_toggled")
	HammerButton.connect("toggled", self, "_on_WeaponTypeButton_toggled")
	SwordButton.meta.weapon_type = WeaponType.SWORD
	AxeButton.meta.weapon_type = WeaponType.AXE
	HammerButton.meta.weapon_type = WeaponType.HAMMER
	SwordButton.group = button_group
	AxeButton.group = button_group
	HammerButton.group = button_group

func clear_input():
	if pressed_button:
		pressed_button.pressed = false

func _on_WeaponTypeButton_toggled(button_pressed):
	pressed_button = button_group.get_pressed_button()
	emit_signal("weapon_type_selected", pressed_button.meta.weapon_type)
