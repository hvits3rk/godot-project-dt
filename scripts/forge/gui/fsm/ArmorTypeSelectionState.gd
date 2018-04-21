func handle_input(forgeGUI, input):
	var ForgeState = forgeGUI.State
	match input:
		ForgeState.ITEM_NAME_SELECTION:
			return ForgeState.ItemNameSelectionState.new()
	return null

func enter(forgeGUI):
	pass

func update(forgeGUI):
	print("ARMOR_TYPE_SELECTION state")

func exit(forgeGUI):
	pass