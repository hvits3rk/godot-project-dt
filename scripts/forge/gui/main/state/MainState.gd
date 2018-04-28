extends Node

func handle_input(host, event):
	match event:
		host.States.ITEM_CREATION:
			return host.States.ItemCreationState.new()
	return null

func enter(host):
	print("ItemCreationMenu: MAIN state entered")
	for child in host.TopGuiContainer.get_children():
		child.visible = true
	for child in host.BottomGuiContainer.get_children():
		child.visible = true

func update(host, delta):
	print("ItemCreationMenu: MAIN state updating")

func exit(host):
	print("ItemCreationMenu: MAIN state exited")
	for child in host.TopGuiContainer.get_children():
		child.visible = false
	for child in host.BottomGuiContainer.get_children():
		child.visible = false
