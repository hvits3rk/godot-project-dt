extends GridContainer

signal armor_type_selected

const ArmorType = preload("res://scripts/forge/common/enum/ArmorType.gd")

onready var HelmetButton = find_node("HelmetButton")
onready var ShoulderButton = find_node("ShoulderButton")
onready var ChestplateButton = find_node("ChestplateButton")
onready var GlovesButton = find_node("GlovesButton")
onready var PantsButton = find_node("PantsButton")
onready var BootsButton = find_node("BootsButton")

var button_group
var pressed_button

func _ready():
	button_group = ButtonGroup.new()
	HelmetButton.connect("toggled", self, "_on_ArmorTypeButton_toggled")
	ShoulderButton.connect("toggled", self, "_on_ArmorTypeButton_toggled")
	ChestplateButton.connect("toggled", self, "_on_ArmorTypeButton_toggled")
	GlovesButton.connect("toggled", self, "_on_ArmorTypeButton_toggled")
	PantsButton.connect("toggled", self, "_on_ArmorTypeButton_toggled")
	BootsButton.connect("toggled", self, "_on_ArmorTypeButton_toggled")
	
	HelmetButton.meta.armor_type = ArmorType.HELMET
	ShoulderButton.meta.armor_type = ArmorType.SHOULDER
	ChestplateButton.meta.armor_type = ArmorType.CHESTPLATE
	GlovesButton.meta.armor_type = ArmorType.GLOVES
	PantsButton.meta.armor_type = ArmorType.PANTS
	BootsButton.meta.armor_type = ArmorType.BOOTS
	
	HelmetButton.group = button_group
	ShoulderButton.group = button_group
	ChestplateButton.group = button_group
	GlovesButton.group = button_group
	PantsButton.group = button_group
	BootsButton.group = button_group

func clear_input():
	if pressed_button:
		pressed_button.pressed = false

func _on_ArmorTypeButton_toggled(button_pressed):
	pressed_button = button_group.get_pressed_button()
	emit_signal("armor_type_selected", pressed_button.meta.armor_type)