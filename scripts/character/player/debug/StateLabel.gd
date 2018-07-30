extends Label

onready var Player = get_parent()

func _ready():
	Player.connect("state_changed", self, "_Player_on_state_changed")

func _Player_on_state_changed(state_name):
	text = state_name
