extends "../common/PartSelectorBase.gd"

signal pommel_selected(button_meta)

func _ready():
	signal_name = "pommel_selected"