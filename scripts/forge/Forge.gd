extends Node

signal state_changed
signal progress_changed
signal item_created

onready var ForgeGUI = get_node("ForgeGUI")

const ForgeState = preload("res://scripts/forge/common/enum/ForgeState.gd")

const PROGRESS_MAX = 100

var progress = 0
var state

var created_items_list = []
var item_in_production = {
	"name": "",
	"description": ""
}

func _ready():
	ForgeGUI.connect("production_started", self, "_on_ForgeGUI_production_started")
	state = ForgeState.IDLE
	emit_signal("state_changed", state)
	emit_signal("progress_changed", progress)

func _process(delta):
	match state:
		ForgeState.IDLE:
			return
		ForgeState.CREATING_ITEM:
			creating_item(delta)

func creating_item(delta):
	progress += delta * 20
	emit_signal("progress_changed", progress)
	
	if progress >= PROGRESS_MAX:
		progress = PROGRESS_MAX
		state = ForgeState.IDLE
		emit_signal("progress_changed", progress)
		emit_signal("item_created")
		emit_signal("state_changed", state)
		print("Item created: [name: '{name}', description: '{description}']".format(item_in_production))
		var new_item = item_in_production.duplicate()
		created_items_list.append(new_item)
		print("Inventory")
		for item in created_items_list:
			print("[name: '{name}', description: '{description}']".format(item))

func _on_ForgeGUI_production_started(item_name, item_description):
	progress = 0
	state = ForgeState.CREATING_ITEM
	item_in_production["name"] = item_name
	item_in_production["description"] = item_description
	print("Creating item: [name: '{name}', description: '{description}']".format(item_in_production))
	emit_signal("state_changed", state)