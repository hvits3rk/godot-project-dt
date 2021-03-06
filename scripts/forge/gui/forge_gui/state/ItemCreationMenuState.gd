extends Node

onready var States = get_parent()
onready var PDA = States.get_parent()

func handle_event(host, event):
	match event:
		States.INIT:
			return States.InitState
		States.ITEM_CREATION_PROCESS:
			return States.ItemCreationProcessState
	return null

func enter(host):
	print("ForgeGui: ITEM_CREATION_MENU state entered")
	if PDA.current_state != States.ITEM_CREATION_MENU:
		PDA.current_state = States.ITEM_CREATION_MENU
		PDA.emit_signal("state_changed", PDA.current_state)
	host.TopGuiContainer.visible = false
	host.BottomGuiContainer.visible = false
	host.item_creation_menu_instance = host.ItemCreationMenu.instance()
	host.CenterGuiContainer.add_child(host.item_creation_menu_instance)
	host.item_creation_menu_instance.connect("menu_closed", host, "_on_ItemCreationMenu_menu_closed")
	host.item_creation_menu_instance.connect("item_model_created", host, "_on_ItemCreationMenu_item_model_created")

func update(host, delta):
	print("ForgeGui: ITEM_CREATION_MENU state updating")
	PDA.set_process(false)
	return false

func exit(host):
	print("ForgeGui: ITEM_CREATION_MENU state exited")
	host.TopGuiContainer.visible = true
	host.BottomGuiContainer.visible = true
	host.item_creation_menu_instance.visible = false
	host.item_creation_menu_instance.queue_free()