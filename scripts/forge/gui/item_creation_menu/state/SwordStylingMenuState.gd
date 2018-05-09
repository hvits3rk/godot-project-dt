extends Node

onready var States = get_parent()
onready var PDA = States.get_parent()
onready var Host = PDA.get_parent()
onready var SwordStylingMenu = Host.find_node("SwordStylingMenu")

func handle_event(host, event):
	match event:
		States.NEXT_MENU:
			return States.CollectAndEmitDataState
		States.PREV_MENU:
			PDA.end_current_state()
	return null

func enter(host):
	print("ItemCreationMenu: SWORD_STYLING_MENU state entered")
	if PDA.current_state != States.SWORD_STYLING_MENU:
		PDA.current_state = States.SWORD_STYLING_MENU
		PDA.emit_signal("state_changed", PDA.current_state)
	SwordStylingMenu.visible = true
	if !SwordStylingMenu.is_connected("parts_selected", self, "_on_SwordStylingMenu_parts_selected"):
		SwordStylingMenu.connect("parts_selected", self, "_on_SwordStylingMenu_parts_selected")

func update(host, delta):
	print("ItemCreationMenu: SWORD_STYLING_MENU state updating")
	PDA.set_process(false)
	return false

func exit(host):
	print("ItemCreationMenu: SWORD_STYLING_MENU state exited")
	SwordStylingMenu.visible = false
	if !SwordStylingMenu.is_connected("parts_selected", self, "_on_SwordStylingMenu_parts_selected"):
		SwordStylingMenu.disconnect("parts_selected", self, "_on_SwordStylingMenu_parts_selected")

func _on_SwordStylingMenu_parts_selected(parts):
	Host.item_model.texture = parts