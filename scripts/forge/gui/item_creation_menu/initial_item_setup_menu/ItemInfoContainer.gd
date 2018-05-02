extends GridContainer

signal item_info_entered

onready var NameInput = get_node("NameInput")
onready var DescriptionInput = get_node("DescriptionInput")
onready var NameLabel = get_node("NameLabel")
onready var DescriptionLabel = get_node("DescriptionLabel")

var item_info = {
	name = "",
	description = ""
}

func _ready():
	NameInput.connect("text_changed", self, "_on_NameInput_text_changed")
	DescriptionInput.connect("focus_exited", self, "_on_DescriptionInput_focus_exited")

func _update_label_color(label, input_text):
	var color = Color(0.96, 0.26, 0.21) if input_text.empty() else Color(1, 1, 1)
	label.set("custom_colors/font_color", color)

func _on_NameInput_text_changed(name_input):
	item_info.name = name_input
	_update_label_color(NameLabel, name_input)
	emit_signal("item_info_entered", item_info.duplicate())

func _on_DescriptionInput_focus_exited():
	item_info.description = DescriptionInput.text
	emit_signal("item_info_entered", item_info.duplicate())
