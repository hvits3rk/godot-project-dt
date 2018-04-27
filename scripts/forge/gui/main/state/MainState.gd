extends Node

func handle_input(host, event):
	match event:
		host.States.ITEM_CREATION:
			return host.States.ItemCreationState.new()
	return null

func enter(host):
	print("MAIN_STATE enter()")
	for child in host.TopGuiContainer.get_children():
		child.visible = true
	for child in host.BottomGuiContainer.get_children():
		child.visible = true

func update(host, delta):
	print("MAIN_STATE update()")

func exit(host):
	print("MAIN_STATE exit()")
	for child in host.TopGuiContainer.get_children():
		child.visible = false
	for child in host.BottomGuiContainer.get_children():
		child.visible = false
