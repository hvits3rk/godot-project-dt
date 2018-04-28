extends Node

enum {
	IDLE,
	CREATING_ITEM
}

var IdleState = preload("res://scripts/forge/state/IdleState.gd")
var CreatingItemState = preload("res://scripts/forge/state/CreatingItemState.gd")