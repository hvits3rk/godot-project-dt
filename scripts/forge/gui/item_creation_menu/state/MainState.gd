extends Node

func handle_input(host, event):
	match event:
		host.States.INITIAL_ITEM_SETUP:
			return host.States.InitialItemSetupState.new()
	return null

func enter(host):
	print("ItemCreationMenu: MAIN state entered")

func update(host, delta):
	print("ItemCreationMenu: MAIN state updating")
	host.set_process(false)
	host.set_state(host.States.INITIAL_ITEM_SETUP)
	return false

func exit(host):
	print("ItemCreationMenu: MAIN state exited")