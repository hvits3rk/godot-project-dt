extends MarginContainer

onready var State = get_node("State")
onready var Inventory = get_node("Inventory")
onready var ButtonOpenInventory = get_node("MarginContainer/ButtonOpenInventory")
onready var ButtonCloseInventory = get_node("Inventory/HBoxContainer/MarginContainer3/ButtonCloseInventory")

var fsm_state
var state

func _ready():
	state = State.ROOT
	fsm_state = State.RootState.new()
	Inventory.visible = false
	ButtonOpenInventory.connect("pressed", self, "_on_ButtonOpenInventory_pressed")
	ButtonCloseInventory.connect("pressed", self, "_on_ButtonCloseInventory_pressed")
	set_process(true)

func _process(delta):
	var new_fsm_state = fsm_state.handle_input(self, state)
	if new_fsm_state != null:
		fsm_state.exit(self)
		fsm_state = new_fsm_state
		fsm_state.enter(self)
	fsm_state.update(self)
	set_process(false)

func _on_ButtonOpenInventory_pressed():
	state = State.OPENED_INVENTORY
	set_process(true)

func _on_ButtonCloseInventory_pressed():
	state = State.ROOT
	set_process(true)
