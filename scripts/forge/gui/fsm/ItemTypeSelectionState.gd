func handle_input(forgeGUI, input):
	var ForgeState = forgeGUI.State
	match input:
		ForgeState.WEAPON_TYPE_SELECTION:
			return ForgeState.WeaponTypeSelectionState.new()
		ForgeState.ARMOR_TYPE_SELECTION:
			return ForgeState.ArmorTypeSelectionState.new()
	return null

func enter(forgeGUI):
	forgeGUI.ItemTypeSelector.visible = true

func update(forgeGUI):
	print("ITEM_TYPE_SELECTION state")

func exit(forgeGUI):
	forgeGUI.ItemTypeSelector.visible = false