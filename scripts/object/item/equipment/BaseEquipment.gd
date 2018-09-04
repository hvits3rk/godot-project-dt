extends "res://scripts/object/item/BaseItem.gd"

onready var anim = get_node("AnimationPlayer")
onready var sprite = get_node("Body/Sprite")

export (float, 1.0, 100.0) var resistance = 1.0

export (float, 0, 100.0) var durability_max = 100.0
export (float) var durability

func _ready():
	item_name = "base equipment"
	durability = durability_max


func use(amount=1.0):
	_take_damage(amount)


func repair(amount=10.0):
	durability += amount
	
	if durability > durability_max:
		durability = durability_max


func _take_damage(amount):
	assert(resistance > 0)
	durability -= amount / resistance
	
	if durability <= 0:
		durability = 0
