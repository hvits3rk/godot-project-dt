extends KinematicBody2D

onready var anim = get_node("AnimationPlayer")
onready var interactable_area = get_node("InteractableArea")
onready var pivot = get_node("Pivot")
onready var stats = get_node("Stats")
onready var backpack = get_node("Pivot/PivotBody/Equipment/Backpack")
onready var equipment = get_node("Pivot/PivotBody/Equipment")


func _ready():
	var pickaxe = {
		id = "0",
		types = [ "tools", "pickaxe" ],
		icon = "res://icon.png",
		texture = "res://icon.png",
		scene = "res://scenes/object/item/equipment/tool/Pickaxe.tscn",
		attributes = {
			item_name = "iron pickaxe",
			durability = 100.0,
			resistance = 1.0
		}
	}

	var axe = {
		id = "0",
		types = [ "tools", "axe" ],
		icon = "res://icon.png",
		texture = "res://icon.png",
		scene = "res://scenes/object/item/equipment/tool/Axe.tscn",
		attributes = {
			item_name = "iron axe",
			durability = 100.0,
			resistance = 1.0
		}
	}
	
	equipment.equip_item(pickaxe)
	equipment.equip_item(axe)


func look_at_position(pos):
	var abs_pivot_scale_x = abs(pivot.scale.x)
	if position.x - pos.x > 0:
		pivot.scale.x = -abs_pivot_scale_x
	else:
		pivot.scale.x = abs_pivot_scale_x
