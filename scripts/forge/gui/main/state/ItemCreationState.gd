extends Node

func handle_input(host, event):
	match event:
		host.States.MAIN:
			return host.States.MainState.new()
	return null

func enter(host):
	print("ITEM_CREATION_STATE enter()")
	host.item_creation_menu_instance = host.ItemCreationMenu.instance()
	host.CenterGuiContainer.add_child(host.item_creation_menu_instance)
	host.item_creation_menu_instance.connect("menu_closed", host, "_on_ItemCreationMenu_menu_closed")

func update(host, delta):
	print("ITEM_CREATION_STATE update()")

func exit(host):
	print("ITEM_CREATION_STATE exit()")
	host.item_creation_menu_instance.visible = false
	host.item_creation_menu_instance = host.item_creation_menu_instance.queue_free()