extends StaticBody2D

var interact = null


func _ready():
	interact = get_node("InteractActions")
	
	interact.actions.chop_tree = {
		animation = "chop",
		resources = null,
		equipment = [ "axe" ],
		products = {
			resources = {
				wood = 5
			}
		}
	}


func perform_action(character, interact_obj):
	var result = interact.perform_action(character, interact_obj)
	
#	if result == null:
#		return null
#
#	visible = false
#	queue_free()
