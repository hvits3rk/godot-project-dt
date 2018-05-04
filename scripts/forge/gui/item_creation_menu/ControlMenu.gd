extends HBoxContainer

signal cancel_button_pressed
signal next_button_pressed
signal back_button_pressed

onready var CancelButton = find_node("CancelButton")
onready var NextButton = find_node("NextButton")
onready var BackButton = find_node("BackButton")

func _ready():
	CancelButton.connect("pressed", self, "_on_CancelButton_pressed")
	NextButton.connect("pressed", self, "_on_NextButton_pressed")
	BackButton.connect("pressed", self, "_on_BackButton_pressed")

## == signal connected methods ==
func _on_CancelButton_pressed():
	emit_signal("cancel_button_pressed")

func _on_NextButton_pressed():
	emit_signal("next_button_pressed")

func _on_BackButton_pressed():
	emit_signal("back_button_pressed")