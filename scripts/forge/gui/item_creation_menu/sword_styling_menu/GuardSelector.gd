extends "../common/PartSelectorBase.gd"

signal guard_selected(button_meta)

func _ready():
	signal_name = "guard_selected"
