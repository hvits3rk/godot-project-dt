extends HBoxContainer

signal styling_type_selected(selected_type)

onready var PommelButton = find_node("PommelButton")
onready var GripButton = find_node("GripButton")
onready var GuardButton = find_node("GuardButton")
onready var BladeButton = find_node("BladeButton")

const WeaponPart = preload("res://scripts/forge/common/enum/WeaponPart.gd")

var button_group

func _ready():
	button_group = ButtonGroup.new()
	PommelButton.meta = { part = WeaponPart.POMMEL }
	GripButton.meta = { part = WeaponPart.GRIP }
	GuardButton.meta = { part = WeaponPart.GUARD }
	BladeButton.meta = { part = WeaponPart.BLADE }
	PommelButton.group = button_group
	GripButton.group = button_group
	GuardButton.group = button_group
	BladeButton.group = button_group
	PommelButton.connect("toggled", self, "_on_Button_toggled")
	GripButton.connect("toggled", self, "_on_Button_toggled")
	GuardButton.connect("toggled", self, "_on_Button_toggled")
	BladeButton.connect("toggled", self, "_on_Button_toggled")

func _on_Button_toggled(button_pressed):
	var toggled_button_meta = button_group.get_pressed_button().meta
	emit_signal("styling_type_selected", toggled_button_meta.part)
