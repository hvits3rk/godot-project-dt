extends Control

signal menu_closed
signal item_model_created

onready var ForgeGui = get_parent().get_parent()
onready var States = get_node("States")
onready var ControlMenu = get_node("MarginContainer/VBoxContainer/ControlMenu")
onready var InitialItemSetupMenu = get_node("MarginContainer/VBoxContainer/InitialItemSetupMenu")

var item_model = {}

var states_stack = []
var menu_state

func _ready():
	ControlMenu.connect("cancel_button_pressed", self, "_on_ControlMenu_cancel_button_pressed")
	ControlMenu.connect("next_button_pressed", self, "_on_ControlMenu_next_button_pressed")
	ControlMenu.connect("back_button_pressed", self, "_on_ControlMenu_back_button_pressed")
	InitialItemSetupMenu.connect("item_info_prepaired", self, "_on_InitialItemSetupMenu_item_info_prepaired")
	menu_state = States.MAIN
	states_stack.push_front(States.MainState.new())

func _process(delta):
	if states_stack.front().update(self, delta):
		states_stack.pop_front().exit(self)

func set_state(state):
	var new_state = states_stack.front().handle_input(self, state)
	if new_state:
		menu_state = state
		states_stack.push_front(new_state)
		states_stack.front().enter(self)
		set_process(true)

## == signal connected methods ==
# ControlMenu
func _on_ControlMenu_cancel_button_pressed():
	emit_signal("menu_closed")

func _on_ControlMenu_next_button_pressed():
	if !item_model.empty():
		print("ItemCreationMenu:\n==============\n{0}\n==============".format([item_model]))
		emit_signal("item_model_created", item_model.duplicate())

func _on_ControlMenu_back_button_pressed():
	pass

# InitialItemSetupMenu
func _on_InitialItemSetupMenu_item_info_prepaired(formed_item):
	if formed_item:
		ControlMenu.NextButton.disabled = false
		for key in formed_item.keys():
			item_model[key] = formed_item[key]
	else:
		ControlMenu.NextButton.disabled = true
		item_model.clear()
