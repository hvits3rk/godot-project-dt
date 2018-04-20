extends MarginContainer

enum { ROOT, PRODUCTION }

signal production_started

onready var Main = get_parent()
onready var ItemCreationProgressBar = get_node("VBoxContainer/Top/MarginContainer/ItemCreationProgressBar")
onready var InputFields = get_node("VBoxContainer/Center/InputFields")
onready var ButtonCreateItem = get_node("VBoxContainer/Bottom/MarginContainer/ButtonCreateItem")

const MainState = preload("res://scripts/common/enum/MainState.gd")

func _ready():
	InputFields.visible = false
	ItemCreationProgressBar.visible = false
	Main.connect("item_created", self, "_on_Main_item_created")
	Main.connect("progress_changed", self, "_on_Main_progress_changed")
	Main.connect("state_changed", self, "_on_Main_state_changed")
	InputFields.connect("production_started", self, "_on_InputFields_production_started")
	ButtonCreateItem.connect("pressed", self, "_on_ButtonCreateItem_pressed")

func _on_Main_item_created():
	yield(get_tree().create_timer(1.0), "timeout")
	ItemCreationProgressBar.visible = false
	ButtonCreateItem.visible = true

func _on_Main_progress_changed(new_progress):
	ItemCreationProgressBar.value = new_progress

func _on_Main_state_changed(new_state):
	pass

func _on_InputFields_production_started(item_name, item_description):
	InputFields.visible = false
	ItemCreationProgressBar.visible = true
	emit_signal("production_started", item_name, item_description)

func _on_ButtonCreateItem_pressed():
	ButtonCreateItem.visible = false
	InputFields.visible = true