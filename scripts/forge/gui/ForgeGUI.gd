extends MarginContainer

signal production_started

onready var Forge = get_parent()
onready var ItemCreationProgressBar = get_node("VBoxContainer/Top/MarginContainer/ItemCreationProgressBar")
onready var ItemNameSelector = get_node("VBoxContainer/Center/ItemNameSelector")
onready var ButtonCreateItem = get_node("VBoxContainer/Bottom/MarginContainer/ButtonCreateItem")
onready var ItemTypeSelector = get_node("VBoxContainer/Center/ItemTypeSelector")
onready var WeaponTypeSelector = get_node("VBoxContainer/Center/WeaponTypeSelector")
onready var State = get_node("State")

const ForgeState = preload("res://scripts/forge/common/enum/ForgeState.gd")
const WeaponType = preload("res://scripts/forge/common/enum/WeaponType.gd")
const ItemType = preload("res://scripts/forge/common/enum/ItemType.gd")
const IdleState = preload("res://scripts/forge/gui/fsm/IdleState.gd")

var state
var fsm_state

var item = {}

func _ready():
	Forge.connect("item_created", self, "_on_Forge_item_created")
	Forge.connect("progress_changed", self, "_on_Forge_progress_changed")
	Forge.connect("state_changed", self, "_on_Forge_state_changed")
	ItemNameSelector.connect("item_name_selected", self, "_on_ItemNameSelector_item_name_selected")
	ButtonCreateItem.connect("pressed", self, "_on_ButtonCreateItem_pressed")
	ItemTypeSelector.connect("item_type_chosen", self, "_on_ItemTypeSelector_item_type_chosen")
	WeaponTypeSelector.connect("weapon_type_chosen", self, "_on_WeaponTypeSelector_weapon_type_chosen")
	ItemNameSelector.visible = false
	ItemCreationProgressBar.visible = false
	ItemTypeSelector.visible = false
	WeaponTypeSelector.visible = false
	fsm_state = IdleState.new()

func _process(delta):
	var new_fsm_state = fsm_state.handle_input(self, state)
	if new_fsm_state != null:
		fsm_state.exit(self)
		fsm_state = new_fsm_state
		fsm_state.enter(self)
	
	fsm_state.update(self)
	
	set_process(false)

func _on_Forge_item_created():
	state = State.IDLE
	yield(get_tree().create_timer(1.0), "timeout")
	set_process(true)

func _on_Forge_progress_changed(new_progress):
	ItemCreationProgressBar.value = new_progress

func _on_Forge_state_changed(new_state):
	pass

func _on_ItemNameSelector_item_name_selected(item_name, item_description):
	state = State.PRODUCTION_STARTED
	set_process(true)
	item.name = item_name
	item.description = item_description
	emit_signal("production_started", item)

func _on_ButtonCreateItem_pressed():
	state = State.ITEM_TYPE_SELECTION
	set_process(true)

func _on_ItemTypeSelector_item_type_chosen(item_type):
	match item_type:
		ItemType.WEAPON:
			state = State.WEAPON_TYPE_SELECTION
			item.item_type = item_type
		ItemType.ARMOR:
			pass
	set_process(true)

func _on_WeaponTypeSelector_weapon_type_chosen(weapon_type):
	match weapon_type:
		WeaponType.SWORD:
			item.weapon_type = weapon_type
		WeaponType.AXE:
			pass
		WeaponType.HAMMER:
			pass
	state = State.ITEM_NAME_SELECTION
	set_process(true)