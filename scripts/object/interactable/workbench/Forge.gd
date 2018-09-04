extends StaticBody2D

var interact = null


func _ready():
	interact = get_node("InteractActions")
	
	interact.actions.create_sword = {
		animation = "forge",
		resources = {
			wood = 5,
			ore = 3
		},
		equipment = null,
		products = {
			equipment = {
				weapons = [{
					id = "1",
					types = [ "weapon", "melee", "sword" ],
					icon = "res://icon.png",
					texture = "res://icon.png",
					scene = "res://scenes/object/item/equipment/tool/Pickaxe.tscn",
					attributes = {
						item_name = "iron sword",
						durability = 100.0,
						resistance = 10.0
					}
				}]
			}
		}
	}
	
	interact.actions.create_pickaxe = {
		animation = "forge",
		resources = {
			wood = 3,
			ore = 1
		},
		equipment = null,
		products = {
			equipment = {
				weapons = [{
					id = "2",
					types = [ "tools", "pickaxe" ],
					icon = "res://icon.png",
					texture = "res://icon.png",
					scene = "res://scenes/object/item/equipment/tool/Pickaxe.tscn",
					attributes = {
						item_name = "iron pickaxe",
						durability = 100.0,
						resistance = 1.0
					}
				}]
			}
		}
	}
	
	interact.actions.create_axe = {
		animation = "forge",
		resources = {
			wood = 3,
			ore = 1
		},
		equipment = null,
		products = {
			equipment = {
				weapons = [{
					id = "3",
					types = [ "tools", "axe" ],
					icon = "res://icon.png",
					texture = "res://icon.png",
					scene = "res://scenes/object/item/equipment/tool/Axe.tscn",
					attributes = {
						item_name = "iron axe",
						durability = 100.0,
						resistance = 1.0
					}
				}]
			}
		}
	}
