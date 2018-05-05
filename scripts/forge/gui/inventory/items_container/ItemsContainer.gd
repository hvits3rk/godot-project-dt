extends GridContainer

signal item_selected

const InventoryItemButton = preload("res://scenes/forge/gui/inventory/items_container/component/InventoryItemButton.tscn")

var button_group
var inventory_item_buttons = []

func _ready():
	button_group = ButtonGroup.new()

func add_item(item):
	var item_button = InventoryItemButton.instance()
	item_button.meta = item.duplicate()
	item_button.text = item.item_name
	item_button.group = button_group
	item_button.connect("toggled", self, "_on_InventoryItemButton_toggled")
	inventory_item_buttons.append(item_button)
	add_child(item_button)

func remove_item_by_id(item_id):
	for i in range(inventory_item_buttons.size()):
		if inventory_item_buttons[i].meta.id == item_id:
			var removed_item = inventory_item_buttons[i]
			inventory_item_buttons.remove(i)
			removed_item.queue_free()
			return

func clear_inventory():
	for item_button in inventory_item_buttons:
		item_button.queue_free()
	inventory_item_buttons.clear()

func refresh_inventory(items):
	clear_inventory()
	for item in items:
		add_item(item)

func _on_InventoryItemButton_toggled(button_pressed):
	var pressed_item = button_group.get_pressed_button()
	emit_signal("item_selected", pressed_item.meta)
