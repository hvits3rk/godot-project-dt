extends Node

enum {
	IDLE,
	PRODUCTION_INIT,
	PRODUCTION_STARTED,
	PRODUCTION_ENDED,
	ITEM_TYPE_SELECTION,
	WEAPON_TYPE_SELECTION,
	ARMOR_TYPE_SELECTION,
	ITEM_NAME_SELECTION
}

const IdleState = preload("res://scripts/forge/gui/fsm/IdleState.gd")
const ItemTypeSelectionState = preload("res://scripts/forge/gui/fsm/ItemTypeSelectionState.gd")
const WeaponTypeSelectionState = preload("res://scripts/forge/gui/fsm/WeaponTypeSelectionState.gd")
const ArmorTypeSelectionState = preload("res://scripts/forge/gui/fsm/ArmorTypeSelectionState.gd")
const ItemNameSelectionState = preload("res://scripts/forge/gui/fsm/ItemNameSelectionState.gd")
const ProductionStartedState = preload("res://scripts/forge/gui/fsm/ProductionStartedState.gd")