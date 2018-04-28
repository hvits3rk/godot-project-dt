extends Node

func handle_input(host, event):
	match event:
		host.States.MAIN:
			return host.States.MainState.new()
	return null

func enter(host):
	print("ForgeGui: ITEM_CREATION_PROCESS state entered")
	host.BottomGuiContainer.CreateItemButton.visible = false

func update(host, delta):
	print("ForgeGui: ITEM_CREATION_PROCESS state updating")

func exit(host):
	print("ForgeGui: ITEM_CREATION_PROCESS state exited")
	host.BottomGuiContainer.CreateItemButton.visible = true