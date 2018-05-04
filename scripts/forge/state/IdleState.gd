extends Node

func handle_event(host, event):
	match event:
		host.States.CREATING_ITEM:
			return host.States.CreatingItemState.new()
	return null

func enter(host):
	print("Forge: IDLE state entered")
	if host.current_state != host.States.IDLE:
		host.current_state = host.States.IDLE
		host.emit_signal("state_changed", host.current_state)

func update(host, delta):
	print("Forge: IDLE state updating")
	host.set_process(false)
	return false

func exit(host):
	print("Forge: IDLE state exited")