extends VBoxContainer

signal production_started

onready var States = get_node("States")
onready var TopGuiContainer = get_node("TopGuiContainer")
onready var CenterGuiContainer = get_node("CenterGuiContainer")
onready var BottomGuiContainer = get_node("BottomGuiContainer")

var ItemCreationMenu = preload("res://scenes/forge/gui/ItemCreationMenu.tscn")
var item_creation_menu_instance

var state
var fsm_state

func _ready():
	BottomGuiContainer.connect("create_item_button_pressed", self, "_on_BottomGuiContainer_create_item_button_pressed")
	state = States.MAIN
	fsm_state = States.MainState.new()

func _process(delta):
	var new_fsm_state = fsm_state.handle_input(self, state)
	if new_fsm_state:
		fsm_state.exit(self)
		fsm_state = new_fsm_state
		fsm_state.enter(self)

	fsm_state.update(self, delta)
	set_process(false)

## == public methods ==
func change_state(new_state):
	state = new_state
	set_process(true)

## == signal connected methods ==
# BottomGuiContainer signals
func _on_BottomGuiContainer_create_item_button_pressed():
	change_state(States.ITEM_CREATION)

# ItemCreationMenu signals
func _on_ItemCreationMenu_menu_closed():
	change_state(States.MAIN)
