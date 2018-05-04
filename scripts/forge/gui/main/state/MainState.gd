extends Node

func handle_event(host, event):
	match event:
		host.States.ITEM_CREATION_MENU:
			return host.States.ItemCreationMenuState.new()
	return null

func enter(host):
	print("ForgeGui: MAIN state entered")
	if host.current_state != host.States.MAIN:
		host.current_state = host.States.MAIN
		host.emit_signal("state_changed", host.current_state)


func update(host, delta):
	print("ForgeGui: MAIN state updating")
	host.set_process(false)
	return false

func exit(host):
	print("ForgeGui: MAIN state exited")
