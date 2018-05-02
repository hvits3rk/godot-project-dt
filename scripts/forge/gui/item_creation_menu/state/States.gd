extends Node

enum {
	MAIN,
	INITIAL_ITEM_SETUP,
	GRAPHICAL_ITEM_SETUP
}

const MainState = preload("res://scripts/forge/gui/item_creation_menu/state/MainState.gd")
const InitialItemSetupState = preload("res://scripts/forge/gui/item_creation_menu/state/InitialItemSetupState.gd")