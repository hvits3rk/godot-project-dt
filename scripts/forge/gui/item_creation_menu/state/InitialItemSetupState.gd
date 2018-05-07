extends Node

onready var States = get_parent()
onready var PDA = States.get_parent()

func handle_event(host, event):
	match event:
		States.INIT:
			return States.InitState
	return null

func enter(host):
	print("ItemCreationMenu: INITIAL_ITEM_SETUP state entered")
	if PDA.current_state != States.INITIAL_ITEM_SETUP:
		PDA.current_state = States.INITIAL_ITEM_SETUP
		PDA.emit_signal("state_changed", PDA.current_state)
	host.InitialItemSetupMenu.visible = true

func update(host, delta):
	print("ItemCreationMenu: INITIAL_ITEM_SETUP state updating")
	PDA.set_process(false)
	return false

func exit(host):
	print("ItemCreationMenu: INITIAL_ITEM_SETUP state exited")
	host.InitialItemSetupMenu.visible = false