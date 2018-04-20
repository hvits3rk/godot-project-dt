extends VBoxContainer

signal production_started

onready var ButtonStartProduction = get_node("ButtonStartProduction")
onready var ItemNameInput = get_node("ItemNameInput/HBoxContainer/LineEdit")
onready var ItemDescriptionInput = get_node("ItemDescriptionInput/HBoxContainer/LineEdit")

func _ready():
	ButtonStartProduction.connect("pressed", self, "_on_ButtonStartProduction_pressed")

func _on_ButtonStartProduction_pressed():
	var item_name = ItemNameInput.text
	var item_description = ItemDescriptionInput.text
	emit_signal("production_started", item_name, item_description)
