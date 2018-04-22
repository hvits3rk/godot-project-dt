extends Node

signal state_changed
signal progress_changed
signal item_created

onready var ForgeGUI = get_node("ForgeGUI")

const ForgeState = preload("res://scripts/forge/common/enum/ForgeState.gd")

const PROGRESS_MAX = 100

var progress = 0
var state

var item_in_production = {}

func _ready():
	ForgeGUI.connect("production_started", self, "_on_ForgeGUI_production_started")
	state = ForgeState.IDLE
	emit_signal("state_changed", state)
	emit_signal("progress_changed", progress)
	set_process(false)

func _process(delta):
	match state:
		ForgeState.IDLE:
			return
		ForgeState.CREATING_ITEM:
			creating_item(delta)

func creating_item(delta):
	progress += delta * 100
	emit_signal("progress_changed", progress)
	
	if progress >= PROGRESS_MAX:
		progress = PROGRESS_MAX
		state = ForgeState.IDLE
		emit_signal("progress_changed", progress)
		emit_signal("state_changed", state)
		var new_item = item_in_production.duplicate()
		emit_signal("item_created", new_item)
		set_process(false)

func _on_ForgeGUI_production_started(item):
	progress = 0
	state = ForgeState.CREATING_ITEM
	item_in_production = item.duplicate()
	emit_signal("state_changed", state)
	set_process(true)