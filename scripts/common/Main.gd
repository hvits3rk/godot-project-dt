extends Node

signal state_changed
signal progress_changed
signal item_created

onready var GUI = get_node("GUI")

const MainState = preload("res://scripts/common/enum/MainState.gd")

const PROGRESS_MAX = 100

var progress = 0
var state

func _ready():
	GUI.connect("production_started", self, "_on_GUI_production_started")
	state = MainState.IDLE
	emit_signal("state_changed", state)
	emit_signal("progress_changed", progress)

func _process(delta):
	match state:
		MainState.IDLE:
			return
		MainState.CREATING_ITEM:
			progress += delta * 10
			emit_signal("progress_changed", progress)
			
			if progress >= PROGRESS_MAX:
				progress = PROGRESS_MAX
				state = MainState.IDLE
				emit_signal("progress_changed", progress)
				emit_signal("item_created")
				emit_signal("state_changed", state)

func _on_GUI_production_started(item_name, item_description):
	progress = 0
	state = MainState.CREATING_ITEM
	print("Creating item: {name: '%s', description: '%s'}" % [item_name, item_description])
	emit_signal("state_changed", state)