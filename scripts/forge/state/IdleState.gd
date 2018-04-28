extends Node

func handle_input(host, event):
	match event:
		host.States.CREATING_ITEM:
			return host.States.CreatingItemState.new()
	return null

func enter(host):
	print("Forge: IDLE state entered")

func update(host, delta):
	print("Forge: IDLE state updating")
	host.set_process(false)
	return false

func exit(host):
	print("Forge: IDLE state exited")