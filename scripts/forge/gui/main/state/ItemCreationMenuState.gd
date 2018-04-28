extends Node

func handle_input(host, event):
	match event:
		host.States.MAIN:
			return host.States.MainState.new()
		host.States.ITEM_CREATION_PROCESS:
			return host.States.ItemCreationProcessState.new()
	return null

func enter(host):
	print("ForgeGui: ITEM_CREATION_MENU state entered")
	host.TopGuiContainer.visible = false
	host.BottomGuiContainer.visible = false
	host.item_creation_menu_instance = host.ItemCreationMenu.instance()
	host.CenterGuiContainer.add_child(host.item_creation_menu_instance)
	host.item_creation_menu_instance.connect("menu_closed", host, "_on_ItemCreationMenu_menu_closed")
	host.item_creation_menu_instance.connect("item_model_created", host, "_on_ItemCreationMenu_item_model_created")

func update(host, delta):
	print("ForgeGui: ITEM_CREATION_MENU state updating")

func exit(host):
	print("ForgeGui: ITEM_CREATION_MENU state exited")
	host.TopGuiContainer.visible = true
	host.BottomGuiContainer.visible = true
	host.item_creation_menu_instance.visible = false
	host.item_creation_menu_instance = host.item_creation_menu_instance.queue_free()