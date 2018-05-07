extends Node

onready var States = get_parent()
onready var PDA = States.get_parent()

const Constants = preload("res://scripts/forge/common/Constants.gd")

var progress
var progress_chunk_timer

## DEBUG
const DEBUG_DELAY = 2
var debug_timer
##

func handle_event(host, event):
	match event:
		States.INIT:
			return States.InitState
	return null

func enter(host):
	print("Forge: CREATING_ITEM state entered")
	if PDA.current_state != States.CREATING_ITEM:
		PDA.current_state = States.CREATING_ITEM
		PDA.emit_signal("state_changed", PDA.current_state)
	progress = host.progress
	progress_chunk_timer = 0
	debug_timer = 0

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
		host.emit_signal("progress_changed", progress)
		var new_item = host.item_in_production
		new_item.created_date = OS.get_datetime(true)
		new_item.id = new_item.hash()
		host.emit_signal("item_created", new_item)
		print("(Forge)CreatingItemState:\nItem Created\n==============\n{0}\n==============".format([new_item]))
		return true
	
	return false

func exit(host):
	print("Forge: CREATING_ITEM state exited")
	host.progress = 0