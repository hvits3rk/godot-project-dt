extends VBoxContainer

signal item_name_selected

onready var ButtonConfirm = get_node("ButtonConfirm")
onready var ItemNameInput = get_node("ItemNameInput/HBoxContainer/LineEdit")
onready var ItemDescriptionInput = get_node("ItemDescriptionInput/HBoxContainer/LineEdit")

func _ready():
	ButtonConfirm.connect("pressed", self, "_on_ButtonConfirm_pressed")

func _on_ButtonConfirm_pressed():
	var item_name = ItemNameInput.text
	var item_description = ItemDescriptionInput.text
	emit_signal("item_name_selected", item_name, item_description)
