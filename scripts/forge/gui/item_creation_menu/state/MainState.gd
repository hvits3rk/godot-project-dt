extends Node

func handle_event(host, event):
	match event:
		host.States.INITIAL_ITEM_SETUP:
			return host.States.InitialItemSetupState.new()
	return null

func enter(host):
	print("ItemCreationMenu: MAIN state entered")
	if host.current_state != host.States.MAIN:
		host.current_state = host.States.MAIN
		host.emit_signal("state_changed", host.current_state)


func update(host, delta):
	print("ItemCreationMenu: MAIN state updating")
	host.set_process(false)
	host.append_state(host.States.INITIAL_ITEM_SETUP)
	return false

func exit(host):
	print("ItemCreationMenu: MAIN state exited")