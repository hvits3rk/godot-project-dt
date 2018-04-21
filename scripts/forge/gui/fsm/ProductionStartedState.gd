func handle_input(forgeGUI, input):
	var ForgeState = forgeGUI.State
	match input:
		ForgeState.IDLE:
			return ForgeState.IdleState.new()
	return null

func enter(forgeGUI):
	forgeGUI.ItemCreationProgressBar.visible = true

func update(forgeGUI):
	print("PRODUCTION_STARTED state")

func exit(forgeGUI):
	forgeGUI.ItemCreationProgressBar.visible = false