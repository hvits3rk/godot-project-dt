extends Node

enum {
	MAIN,
	ITEM_CREATION_MENU,
	ITEM_CREATION_PROCESS,
}

const MainState = preload("res://scripts/forge/gui/main/state/MainState.gd")
const ItemCreationMenuState = preload("res://scripts/forge/gui/main/state/ItemCreationMenuState.gd")
const ItemCreationProcessState = preload("res://scripts/forge/gui/main/state/ItemCreationProcessState.gd")
