extends MarginContainer

signal inventory_closed

onready var InventoryGui = get_node("InventoryGui")

func _ready():
	InventoryGui.visible = false
	InventoryGui.connect("inventory_closed", self, "_on_InventoryGui_inventory_closed")

func _on_InventoryGui_inventory_closed():
	emit_signal("inventory_closed")
