extends Node

const Constants = preload("res://scripts/forge/common/Constants.gd")

var progress
var progress_chunk_timer = 0

## DEBUG
const DEBUG_DELAY = 2
var debug_timer = 0
##

func handle_input(host, event):
	return null

func enter(host):
	print("Forge: CREATING_ITEM state entered")
	progress = host.progress

func update(host, delta):
	## DEBUG
	debug_timer -= delta
	if debug_timer <= 0:
		debug_timer = DEBUG_DELAY
		print("Forge: CREATING_ITEM state updating")
	## DEBUG
	
	progress += delta * Constants.PROGRESS_SPEED
	progress_chunk_timer += delta * Constants.PROGRESS_SPEED
	
	if progress_chunk_timer >= Constants.PROGRESS_CHUNK:
		progress_chunk_timer = 0
		host.emit_signal("progress_changed", progress)
	
	if progress >= Constants.PROGRESS_MAX:
		progress = Constants.PROGRESS_MAX
		host.set_state(host.States.IDLE)
		host.emit_signal("progress_changed", progress)
		var new_item = host.item_in_production.duplicate()
		host.emit_signal("item_created", new_item)
		print("(Forge)CreatingItemState:\nItem Created\n==============\n{0}\n==============".format([new_item]))
		return true
	
	return false

func exit(host):
	print("Forge: CREATING_ITEM state exited")
	host.progress = 0