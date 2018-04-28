extends MarginContainer

signal menu_closed
signal item_model_created

onready var ForgeGui = get_node("/root/Forge/ForgeGui")
onready var ControlMenu = get_node("MarginContainer/VBoxContainer/ControlMenu")


func _ready():
	ControlMenu.connect("cancel_button_pressed", self, "_on_ControlMenu_cancel_button_pressed")
	ControlMenu.connect("next_button_pressed", self, "_on_ControlMenu_next_button_pressed")
	ControlMenu.connect("back_button_pressed", self, "_on_ControlMenu_back_button_pressed")

## == signal connected methods ==
func _on_ControlMenu_cancel_button_pressed():
	emit_signal("menu_closed")

func _on_ControlMenu_next_button_pressed():
	emit_signal("item_model_created")

func _on_ControlMenu_back_button_pressed():
	pass