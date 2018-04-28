extends MarginContainer

onready var ForgeGui = get_parent()
onready var ItemCreationProgress = get_node("MarginContainer/VBoxContainer/HBoxContainer/ItemCreationProgress")
onready var Tween = get_node("Tween")

func _ready():
	ForgeGui.connect("production_started", self, "_on_ForgeGui_production_started")
	ItemCreationProgress.visible = false

# Forge signals
func _on_Forge_progress_changed(progress):
	ItemCreationProgress.value = progress

func _on_Forge_item_created(item):
	yield(get_tree().create_timer(0.5), "timeout")
	ItemCreationProgress.visible = false

# ForgeGui signals
func _on_ForgeGui_production_started(item):
	ItemCreationProgress.visible = true