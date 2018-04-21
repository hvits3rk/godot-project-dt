func handle_input(forgeGUI, input):
	var ForgeState = forgeGUI.State
	match input:
		ForgeState.PRODUCTION_STARTED:
			return ForgeState.ProductionStartedState.new()
	return null

func enter(forgeGUI):
	forgeGUI.ItemNameSelector.visible = true

func update(forgeGUI):
	print("ITEM_NAME_SELECTION state")

func exit(forgeGUI):
	forgeGUI.ItemNameSelector.visible = false