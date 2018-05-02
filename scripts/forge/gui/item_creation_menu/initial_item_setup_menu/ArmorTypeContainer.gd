extends GridContainer

signal armor_type_selected

const ArmorType = preload("res://scripts/forge/common/enum/ArmorType.gd")

onready var HelmetButton = get_node("HelmetButton")
onready var ShoulderButton = get_node("ShoulderButton")
onready var ChestplateButton = get_node("ChestplateButton")
onready var GlovesButton = get_node("GlovesButton")
onready var PantsButton = get_node("PantsButton")
onready var BootsButton = get_node("BootsButton")

var button_group

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

func _on_ArmorTypeButton_toggled(button_pressed):
	var pressed_button = button_group.get_pressed_button()
	emit_signal("armor_type_selected", pressed_button.meta.armor_type)
	print("{0}".format([pressed_button.meta]))