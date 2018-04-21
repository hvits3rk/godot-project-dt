func handle_input(playerGUI, input):
	var playerGuiState = playerGUI.State
	match input:
		playerGuiState.ROOT:
			return playerGuiState.RootState.new()
	return null

func enter(playerGUI):
	playerGUI.Inventory.visible = true

func update(playerGUI):
	pass

func exit(playerGUI):
	playerGUI.Inventory.visible = false