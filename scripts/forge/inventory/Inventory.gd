extends Node

signal item_added
signal item_deleted

var items = []

onready var Forge = get_parent()

func _ready():
	Forge.connect("item_created", self, "_on_Forge_item_created")

func add_item(new_item):
	items.append(new_item)
	emit_signal("item_added", new_item)

func remove_item_by_id(item_id):
	for i in range(items.size()):
		if items[i].id == item_id:
			var removed_item = items[i]
			items.remove(i)
			emit_signal("item_deleted", removed_item)
			return

func _on_Forge_item_created(item):
	add_item(item.duplicate())
