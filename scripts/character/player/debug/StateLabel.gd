extends Label

onready var Player = get_parent().get_parent()

func _ready():
	Player.connect("state_changed", self, "_Player_on_state_changed")

func _Player_on_state_changed(states_stack):
	text = ""
	for state in states_stack:
		text += "[ " + state.name + " ]  "
