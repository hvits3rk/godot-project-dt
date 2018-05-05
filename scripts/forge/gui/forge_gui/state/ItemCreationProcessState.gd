extends Node

func handle_event(host, event):
	match event:
		host.States.INIT:
			return host.States.InitState.new()
	return null

func enter(host):
	print("ForgeGui: ITEM_CREATION_PROCESS state entered")
	if host.current_state != host.States.ITEM_CREATION_PROCESS:
		host.current_state = host.States.ITEM_CREATION_PROCESS
		host.emit_signal("state_changed", host.current_state)
	host.BottomGuiContainer.CreateItemButton.visible = false

func update(host, delta):
	print("ForgeGui: ITEM_CREATION_PROCESS state updating")
	host.set_process(false)
	return false

func exit(host):
	print("ForgeGui: ITEM_CREATION_PROCESS state exited")
	host.BottomGuiContainer.CreateItemButton.visible = true