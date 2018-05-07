extends Node

signal progress_changed
signal item_created

onready var ForgeGui = get_node("ForgeGui")
onready var PDA = get_node("ForgePDA")
onready var States = get_node("ForgePDA/States")

const Constants = preload("res://scripts/forge/common/Constants.gd")

var progress = 0

var item_in_production = {}

func _ready():
	ForgeGui.connect("production_started", self, "_on_ForgeGui_production_started")
	emit_signal("progress_changed", progress)

## == connected signal methods ==
func _on_ForgeGui_production_started(item_model):
	item_in_production = item_model.duplicate()
	PDA.append_state(States.CREATING_ITEM)
