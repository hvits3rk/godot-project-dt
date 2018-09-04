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
				wood = 15
			}
		}
	}


func perform_action(character, interact_obj):
	var result = interact.perform_action(character, interact_obj)
	
	if result == null:
		return null
	
	var parent = get_parent()
	var stump_scene = load("res://scenes/object/interactable/resource/Stump.tscn")
	var node = stump_scene.instance()
	
	parent.add_child(node)
	node.position.x = position.x
	node.position.y = position.y
	
	visible = false
	queue_free()
