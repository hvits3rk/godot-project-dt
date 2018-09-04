extends StaticBody2D

var interact = null


func _ready():
	interact = get_node("InteractActions")
	
	interact.actions.mine = {
		animation = "mine",
		resources = null,
		equipment = [ "pickaxe" ],
		products = {
			resources = {
				ore = 6
			}
		}
	}
