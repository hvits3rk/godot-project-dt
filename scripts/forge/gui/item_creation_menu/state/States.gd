extends Node

enum {
	INIT,
	INITIAL_ITEM_SETUP,
	GRAPHICAL_ITEM_SETUP
}

const InitState = preload("res://scripts/forge/gui/item_creation_menu/state/InitState.gd")
const InitialItemSetupState = preload("res://scripts/forge/gui/item_creation_menu/state/InitialItemSetupState.gd")