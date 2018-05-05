extends MarginContainer

signal create_item_button_pressed
signal inventory_opened

onready var CreateItemButton = find_node("CreateItemButton")
onready var InventoryButton = find_node("InventoryButton")


func _ready():
	CreateItemButton.connect("pressed", self, "_on_CreateItemButton_pressed")
	InventoryButton.connect("pressed", self, "_on_InventoryButton_pressed")

func _on_CreateItemButton_pressed():
	emit_signal("create_item_button_pressed")

func _on_InventoryButton_pressed():
	emit_signal("inventory_opened")
