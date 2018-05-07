extends Node

onready var States = get_parent()
onready var PDA = States.get_parent()

func handle_event(host, event):
	return null

func enter(host):
	print("BASE: INIT state entered")
	if PDA.current_state != States.INIT:
		PDA.current_state = States.INIT
		PDA.emit_signal("state_changed", PDA.current_state)

func update(host, delta):
	print("BASE: INIT state updating")
	PDA.set_process(false)
	return false

func exit(host):
	print("BASE: INIT state exited")