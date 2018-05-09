extends Node

onready var States = get_parent()
onready var PDA = States.get_parent()

func handle_event(host, event):
	return null

func enter(host):
	print("ItemCreationMenu: COLLECT_AND_EMIT_DATA state entered")
	if PDA.current_state != States.COLLECT_AND_EMIT_DATA:
		PDA.current_state = States.COLLECT_AND_EMIT_DATA
		PDA.emit_signal("state_changed", PDA.current_state)

func update(host, delta):
	print("ItemCreationMenu: COLLECT_AND_EMIT_DATA state updating")
	host.emit_signal("item_model_created", host.item_model)
	PDA.set_process(false)
	return false

func exit(host):
	print("ItemCreationMenu: COLLECT_AND_EMIT_DATA state exited")
