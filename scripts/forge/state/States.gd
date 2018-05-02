extends Node

enum {
	IDLE,
	CREATING_ITEM
}

const IdleState = preload("res://scripts/forge/state/IdleState.gd")
const CreatingItemState = preload("res://scripts/forge/state/CreatingItemState.gd")