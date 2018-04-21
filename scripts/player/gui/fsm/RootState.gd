func handle_input(playerGUI, input):
	var playerGuiState = playerGUI.State
	match input:
		playerGuiState.OPENED_INVENTORY:
			return playerGuiState.OpenedInventoryState.new()
	return null

func enter(playerGUI):
	playerGUI.ButtonOpenInventory.visible = true

func update(playerGUI):
	pass

func exit(playerGUI):
	playerGUI.ButtonOpenInventory.visible = false