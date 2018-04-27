extends MarginContainer

signal create_item_button_pressed

onready var CreateItemButton = get_node("VBoxContainer/CreateItemButton")

func _ready():
	CreateItemButton.connect("pressed", self, "_on_CreateItemButton_pressed")

func _on_CreateItemButton_pressed():
	emit_signal("create_item_button_pressed")
