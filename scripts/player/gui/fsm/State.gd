extends Node

enum {
	ROOT,
	OPENED_INVENTORY
}

const RootState = preload("res://scripts/player/gui/fsm/RootState.gd")
const OpenedInventoryState = preload("res://scripts/player/gui/fsm/OpenedInventoryState.gd")