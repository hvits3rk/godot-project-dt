extends Node

func handle_input(host, event):
	match event:
		host.States.ITEM_CREATION_MENU:
			return host.States.ItemCreationMenuState.new()
	return null

func enter(host):
	print("ForgeGui: MAIN state entered")

func update(host, delta):
	print("ForgeGui: MAIN state updating")

func exit(host):
	print("ForgeGui: MAIN state exited")
