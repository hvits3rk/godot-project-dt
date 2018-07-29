extends "../common/PartSelectorBase.gd"

signal grip_selected(button_meta)

func _ready():
	signal_name = "grip_selected"
