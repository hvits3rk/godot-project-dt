extends GridContainer

signal grip_selected

const GuiToggleButton = preload("res://scenes/forge/gui/component/GuiToggleButton.tscn")

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
	print(pressed_button.meta)
	emit_signal("grip_selected", pressed_button.meta)