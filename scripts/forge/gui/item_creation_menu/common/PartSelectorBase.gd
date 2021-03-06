extends Node

signal button_pressed(button_meta)

const GuiToggleButton = preload("res://scenes/forge/gui/component/GuiToggleButton.tscn")

var signal_name = "button_pressed"

var buttons = []
var button_group

func _ready():
	button_group = ButtonGroup.new()

func add_button(item_part, res):
	var button = GuiToggleButton.instance()
	button.icon = load(res)
	button.group = button_group
	button.meta = { part = item_part, texture_resource = res }
	button.connect("toggled", self, "_on_Button_toggled")
	buttons.append(button)
	add_child(button)

func _on_Button_toggled(button_pressed):
	var pressed_button = button_group.get_pressed_button()
	emit_signal(signal_name, pressed_button.meta)
