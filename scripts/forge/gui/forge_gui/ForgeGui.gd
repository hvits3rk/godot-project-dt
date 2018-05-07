extends VBoxContainer

signal production_started

onready var Forge = get_parent()
onready var PDA = get_node("ForgeGuiPDA")
onready var States = get_node("ForgeGuiPDA/States")
onready var TopGuiContainer = find_node("TopGuiContainer")
onready var CenterGuiContainer = find_node("CenterGuiContainer")
onready var BottomGuiContainer = find_node("BottomGuiContainer")

var ItemCreationMenu = preload("res://scenes/forge/gui/item_creation_menu/ItemCreationMenu.tscn")
var item_creation_menu_instance

func _ready():
	BottomGuiContainer.connect("create_item_button_pressed", self, "_on_BottomGuiContainer_create_item_button_pressed")
	BottomGuiContainer.connect("inventory_opened", self, "_on_BottomGuiContainer_inventory_opened")
	CenterGuiContainer.connect("inventory_closed", self, "_on_CenterGuiContainer_inventory_closed")
	Forge.connect("progress_changed", TopGuiContainer, "_on_Forge_progress_changed")
	Forge.connect("item_created", TopGuiContainer, "_on_Forge_item_created")
	Forge.connect("item_created", self, "_on_Forge_item_created")

## == signal connected methods ==
# Forge
func _on_Forge_item_created(item):
	yield(get_tree().create_timer(1), "timeout")
	PDA.end_current_state()

# BottomGuiContainer
func _on_BottomGuiContainer_create_item_button_pressed():
	PDA.append_state(States.ITEM_CREATION_MENU)

func _on_BottomGuiContainer_inventory_opened():
	TopGuiContainer.visible = false
	BottomGuiContainer.visible = false
	CenterGuiContainer.InventoryGui.visible = true

# CenterGuiContainer
func _on_CenterGuiContainer_inventory_closed():
	TopGuiContainer.visible = true
	BottomGuiContainer.visible = true
	CenterGuiContainer.InventoryGui.visible = false

# ItemCreationMenu
func _on_ItemCreationMenu_menu_closed():
	PDA.end_current_state()

func _on_ItemCreationMenu_item_model_created(item_model):
	emit_signal("production_started", item_model)
	PDA.replace_state(States.ITEM_CREATION_PROCESS)
