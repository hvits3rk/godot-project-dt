extends MarginContainer

enum {
	ROOT,
	PRODUCTION_INIT,
	PRODUCTION_STARTED,
	PRODUCTION_ENDED,
	ITEM_TYPE_SELECTION,
	WEAPON_TYPE_SELECTION,
	ITEM_NAME_SELECTION
}

signal production_started

onready var Forge = get_parent()
onready var ItemCreationProgressBar = get_node("VBoxContainer/Top/MarginContainer/ItemCreationProgressBar")
onready var InputFields = get_node("VBoxContainer/Center/InputFields")
onready var ButtonCreateItem = get_node("VBoxContainer/Bottom/MarginContainer/ButtonCreateItem")
onready var ItemTypeSelector = get_node("VBoxContainer/Center/ItemTypeSelector")
onready var WeaponTypeSelector = get_node("VBoxContainer/Center/WeaponTypeSelector")

const ForgeState = preload("res://scripts/forge/common/enum/ForgeState.gd")
const WeaponType = preload("res://scripts/forge/common/enum/WeaponType.gd")
const ItemType = preload("res://scripts/forge/common/enum/ItemType.gd")

var state = ROOT

func _ready():
	Forge.connect("item_created", self, "_on_Forge_item_created")
	Forge.connect("progress_changed", self, "_on_Forge_progress_changed")
	Forge.connect("state_changed", self, "_on_Forge_state_changed")
	InputFields.connect("production_started", self, "_on_InputFields_production_started")
	ButtonCreateItem.connect("pressed", self, "_on_ButtonCreateItem_pressed")
	ItemTypeSelector.connect("item_type_chosen", self, "_on_ItemTypeSelector_item_type_chosen")
	WeaponTypeSelector.connect("weapon_type_chosen", self, "_on_WeaponTypeSelector_weapon_type_chosen")

func _process(delta):
	match state:
		ROOT:
			InputFields.visible = false
			ItemCreationProgressBar.visible = false
			ItemTypeSelector.visible = false
			WeaponTypeSelector.visible = false
		PRODUCTION_INIT:
			pass
		PRODUCTION_STARTED:
			InputFields.visible = false
			ItemCreationProgressBar.visible = true
		PRODUCTION_ENDED:
			ItemCreationProgressBar.visible = false
			ButtonCreateItem.visible = true
		ITEM_TYPE_SELECTION:
			ButtonCreateItem.visible = false
			ItemTypeSelector.visible = true
		WEAPON_TYPE_SELECTION:
			ItemTypeSelector.visible = false
			WeaponTypeSelector.visible = true
		ITEM_NAME_SELECTION:
			WeaponTypeSelector.visible = false
			InputFields.visible = true
	set_process(false)

func _on_Forge_item_created():
	state = PRODUCTION_ENDED
	yield(get_tree().create_timer(1.0), "timeout")
	set_process(true)

func _on_Forge_progress_changed(new_progress):
	ItemCreationProgressBar.value = new_progress

func _on_Forge_state_changed(new_state):
	pass

func _on_InputFields_production_started(item_name, item_description):
	state = PRODUCTION_STARTED
	set_process(true)
	emit_signal("production_started", item_name, item_description)

func _on_ButtonCreateItem_pressed():
	state = ITEM_TYPE_SELECTION
	set_process(true)

func _on_ItemTypeSelector_item_type_chosen(item_type):
	match item_type:
		ItemType.WEAPON:
			state = WEAPON_TYPE_SELECTION
		ItemType.ARMOR:
			pass
	set_process(true)

func _on_WeaponTypeSelector_weapon_type_chosen(weapon_type):
	match weapon_type:
		WeaponType.SWORD:
			pass
		WeaponType.AXE:
			pass
		WeaponType.HAMMER:
			pass
	state = ITEM_NAME_SELECTION
	set_process(true)