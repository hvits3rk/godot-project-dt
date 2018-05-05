extends Node

func handle_event(host, event):
	match event:
		host.States.CREATING_ITEM:
			return host.States.CreatingItemState.new()
	return null

func enter(host):
	print("Forge: INIT state entered")
	if host.current_state != host.States.INIT:
		host.current_state = host.States.INIT
		host.emit_signal("state_changed", host.current_state)

func update(host, delta):
	print("Forge: INIT state updating")
	host.set_process(false)
	return false

func exit(host):
	print("Forge: INIT state exited")