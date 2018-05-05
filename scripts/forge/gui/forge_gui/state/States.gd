extends Node

enum {
	INIT,
	ITEM_CREATION_MENU,
	ITEM_CREATION_PROCESS,
}

const InitState = preload("res://scripts/forge/gui/forge_gui/state/InitState.gd")
const ItemCreationMenuState = preload("res://scripts/forge/gui/forge_gui/state/ItemCreationMenuState.gd")
const ItemCreationProcessState = preload("res://scripts/forge/gui/forge_gui/state/ItemCreationProcessState.gd")
