func handle_input(forgeGUI, input):
	var ForgeState = forgeGUI.State
	match input:
		ForgeState.ITEM_NAME_SELECTION:
			return ForgeState.ItemNameSelectionState.new()
	return null

func enter(forgeGUI):
	forgeGUI.WeaponTypeSelector.visible = true

func update(forgeGUI):
	print("WEAPON_TYPE_SELECTION state")

func exit(forgeGUI):
	forgeGUI.WeaponTypeSelector.visible = false