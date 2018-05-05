extends "res://scripts/PushDownAutomata.gd"

signal state_changed
signal progress_changed
signal item_created

onready var ForgeGui = get_node("ForgeGui")

const Constants = preload("res://scripts/forge/common/Constants.gd")

var progress = 0

var item_in_production = {}

func _ready():
	ForgeGui.connect("production_started", self, "_on_ForgeGui_production_started")
	emit_signal("progress_changed", progress)

## == connected signal methods ==
func _on_ForgeGui_production_started(item_model):
	item_in_production = item_model.duplicate()
	append_state(States.CREATING_ITEM)
