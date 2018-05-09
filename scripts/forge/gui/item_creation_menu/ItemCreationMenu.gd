extends Control

signal menu_closed
signal item_model_created

const ItemType = preload("res://scripts/forge/common/enum/ItemType.gd")
const WeaponType = preload("res://scripts/forge/common/enum/WeaponType.gd")
const ArmorType = preload("res://scripts/forge/common/enum/ArmorType.gd")

onready var PDA = get_node("ItemCreationMenuPDA")
onready var States = get_node("ItemCreationMenuPDA/States")
onready var ForgeGui = get_node("/root/Forge/ForgeGui")
onready var ControlMenu = find_node("ControlMenu")
onready var InitialItemSetupMenu = find_node("InitialItemSetupMenu")

var item_model = {}

func _ready():
	ControlMenu.connect("cancel_button_pressed", self, "_on_ControlMenu_cancel_button_pressed")
	ControlMenu.connect("next_button_pressed", self, "_on_ControlMenu_next_button_pressed")
	ControlMenu.connect("back_button_pressed", self, "_on_ControlMenu_back_button_pressed")
	InitialItemSetupMenu.connect("item_info_prepaired", self, "_on_InitialItemSetupMenu_item_info_prepaired")

## == signal connected methods ==
# ControlMenu
func _on_ControlMenu_cancel_button_pressed():
	emit_signal("menu_closed")

func _on_ControlMenu_next_button_pressed():
	PDA.append_state(States.NEXT_MENU)

func _on_ControlMenu_back_button_pressed():
	PDA.append_state(States.PREV_MENU)

# InitialItemSetupMenu
func _on_InitialItemSetupMenu_item_info_prepaired(formed_item):
	if formed_item:
		ControlMenu.NextButton.disabled = false
		for key in formed_item.keys():
			item_model[key] = formed_item[key]
	else:
		ControlMenu.NextButton.disabled = true
		item_model.clear()
