extends Node

func handle_input(host, event):
	match event:
		host.States.MAIN:
			return host.States.MainState.new()
	return null

func enter(host):
	print("ItemCreationMenu: INITIAL_ITEM_SETUP state entered")
	host.InitialItemSetupMenu.visible = true

func update(host, delta):
	print("ItemCreationMenu: INITIAL_ITEM_SETUP state updating")
	host.set_process(false)
	return false

func exit(host):
	print("ItemCreationMenu: INITIAL_ITEM_SETUP state exited")
	host.InitialItemSetupMenu.visible = false