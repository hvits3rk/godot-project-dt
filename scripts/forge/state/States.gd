extends Node

enum {
	INIT,
	CREATING_ITEM
}

const InitState = preload("res://scripts/forge/state/InitState.gd")
const CreatingItemState = preload("res://scripts/forge/state/CreatingItemState.gd")