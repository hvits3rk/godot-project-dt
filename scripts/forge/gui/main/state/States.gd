extends Node

enum {
	MAIN,
	ITEM_CREATION_MENU,
	ITEM_CREATION_PROCESS
}

var MainState = preload("res://scripts/forge/gui/main/state/MainState.gd")
var ItemCreationMenuState = preload("res://scripts/forge/gui/main/state/ItemCreationMenuState.gd")
var ItemCreationProcessState = preload("res://scripts/forge/gui/main/state/ItemCreationProcessState.gd")
