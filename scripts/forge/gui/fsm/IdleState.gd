func handle_input(forgeGUI, input):
	var ForgeState = forgeGUI.State
	match input:
		ForgeState.ITEM_TYPE_SELECTION:
			return ForgeState.ItemTypeSelectionState.new()
	return null

func enter(forgeGUI):
	forgeGUI.ButtonCreateItem.visible = true

func update(forgeGUI):
	print("IDLE state")

func exit(forgeGUI):
	forgeGUI.ButtonCreateItem.visible = false