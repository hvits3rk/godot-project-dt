extends VBoxContainer

signal production_started
signal state_changed

onready var Forge = get_parent()
onready var States = get_node("States")
onready var TopGuiContainer = find_node("TopGuiContainer")
onready var CenterGuiContainer = find_node("CenterGuiContainer")
onready var BottomGuiContainer = find_node("BottomGuiContainer")

var ItemCreationMenu = preload("res://scenes/forge/gui/item_creation_menu/ItemCreationMenu.tscn")
var item_creation_menu_instance

var states_stack = []
var current_state

func _ready():
	BottomGuiContainer.connect("create_item_button_pressed", self, "_on_BottomGuiContainer_create_item_button_pressed")
	BottomGuiContainer.connect("inventory_opened", self, "_on_BottomGuiContainer_inventory_opened")
	CenterGuiContainer.connect("inventory_closed", self, "_on_CenterGuiContainer_inventory_closed")
	Forge.connect("progress_changed", TopGuiContainer, "_on_Forge_progress_changed")
	Forge.connect("item_created", TopGuiContainer, "_on_Forge_item_created")
	Forge.connect("item_created", self, "_on_Forge_item_created")
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
		states_stack.pop_front().exit(self)
		states_stack.push_front(new_state)
		states_stack.front().enter(self)
		set_process(true)

func end_current_state():
	if states_stack.size() <= 1:
		print("ForgeGui: Cant end current state, states_stack.size(): %d" % states_stack.size())
		return false
	states_stack.pop_front().exit(self)
	states_stack.front().enter(self)
	return true

func clear_states_stack():
	while end_current_state():
		pass

## == signal connected methods ==
# Forge
func _on_Forge_item_created(item):
	yield(get_tree().create_timer(1), "timeout")
	end_current_state()

# BottomGuiContainer
func _on_BottomGuiContainer_create_item_button_pressed():
	append_state(States.ITEM_CREATION_MENU)

func _on_BottomGuiContainer_inventory_opened():
	TopGuiContainer.visible = false
	BottomGuiContainer.visible = false
	CenterGuiContainer.InventoryGui.visible = true

# CenterGuiContainer
func _on_CenterGuiContainer_inventory_closed():
	TopGuiContainer.visible = true
	BottomGuiContainer.visible = true
	CenterGuiContainer.InventoryGui.visible = false

# ItemCreationMenu
func _on_ItemCreationMenu_menu_closed():
	end_current_state()

func _on_ItemCreationMenu_item_model_created(item_model):
	emit_signal("production_started", item_model)
	replace_state(States.ITEM_CREATION_PROCESS)
