extends Node

onready var States = get_parent()
onready var PDA = States.get_parent()

func handle_event(host, event):
	match event:
		States.INIT:
			return States.InitState
	return null

func enter(host):
	print("ForgeGui: ITEM_CREATION_PROCESS state entered")
	if PDA.current_state != States.ITEM_CREATION_PROCESS:
		PDA.current_state = States.ITEM_CREATION_PROCESS
		PDA.emit_signal("state_changed", PDA.current_state)
	host.BottomGuiContainer.CreateItemButton.visible = false

func update(host, delta):
	print("ForgeGui: ITEM_CREATION_PROCESS state updating")
	PDA.set_process(false)
	return false

func exit(host):
	print("ForgeGui: ITEM_CREATION_PROCESS state exited")
	host.BottomGuiContainer.CreateItemButton.visible = true