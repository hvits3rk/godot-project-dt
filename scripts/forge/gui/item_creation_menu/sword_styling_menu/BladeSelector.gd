extends "../common/PartSelectorBase.gd"

signal blade_selected(button_meta)

func _ready():
	signal_name = "blade_selected"
