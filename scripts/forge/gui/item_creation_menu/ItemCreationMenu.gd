extends Control

signal menu_closed
signal item_model_created
signal state_changed

onready var ForgeGui = get_node("/root/Forge/ForgeGui")
onready var States = get_node("States")
onready var ControlMenu = find_node("ControlMenu")
onready var InitialItemSetupMenu = find_node("InitialItemSetupMenu")

var item_model = {}

var states_stack = []
var current_state

func _ready():
	ControlMenu.connect("cancel_button_pressed", self, "_on_ControlMenu_cancel_button_pressed")
	ControlMenu.connect("next_button_pressed", self, "_on_ControlMenu_next_button_pressed")
	ControlMenu.connect("back_button_pressed", self, "_on_ControlMenu_back_button_pressed")
	InitialItemSetupMenu.connect("item_info_prepaired", self, "_on_InitialItemSetupMenu_item_info_prepaired")
	current_state = States.MAIN
	states_stack.push_front(States.MainState.new())
	states_stack.front().enter(self)

func _process(delta):
	if states_stack.front().update(self, delta):
		end_current_state()

func append_state(state):
	var new_state = states_stack.front().handle_event(self, state)
	if new_state:
		current_state = state
		states_stack.push_front(new_state)
		states_stack.front().enter(self)
		set_process(true)

func replace_state(state):
	var new_state = states_stack.front().handle_event(self, state)
	if new_state:
		current_state = state
		var exited_state = states_stack.pop_front()
		exited_state.exit(self)
		exited_state.queue_free()
		states_stack.push_front(new_state)
		states_stack.front().enter(self)
		set_process(true)

func end_current_state():
	if states_stack.size() <= 1:
		print("ItemCreationMenu: Cant end current state, states_stack.size(): %d" % states_stack.size())
		return false
	var exited_state = states_stack.pop_front()
	exited_state.exit(self)
	exited_state.queue_free()
	states_stack.front().enter(self)
	return true

func clear_states_stack():
	while end_current_state():
		pass

## == signal connected methods ==
# ControlMenu
func _on_ControlMenu_cancel_button_pressed():
	emit_signal("menu_closed")

func _on_ControlMenu_next_button_pressed():
	if !item_model.empty():
		emit_signal("item_model_created", item_model)

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

func _exit_tree():
	clear_states_stack()
	var exited_state = states_stack.pop_front()
	exited_state.exit(self)
	exited_state.queue_free()