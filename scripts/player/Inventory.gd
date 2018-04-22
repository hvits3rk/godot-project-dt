extends MarginContainer

onready var ItemsContainer = get_node("HBoxContainer/MarginContainer/ScrollContainer/ItemsContainer")
onready var Root = get_node("/root/Forge")

const InventoryItem = preload("res://scenes/InventoryItem.tscn")

var items_in_inventory = []

func _ready():
	Root.connect("item_created", self, "add_item")

func add_item(item):
	items_in_inventory.append(item)
	var new_item = InventoryItem.instance()
	new_item.text = item.name
	ItemsContainer.add_child(new_item)