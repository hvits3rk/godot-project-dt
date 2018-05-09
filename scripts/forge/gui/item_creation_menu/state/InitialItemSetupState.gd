extends Node

onready var States = get_parent()
onready var PDA = States.get_parent()

const ItemType = preload("res://scripts/forge/common/enum/ItemType.gd")
const WeaponType = preload("res://scripts/forge/common/enum/WeaponType.gd")
const ArmorType = preload("res://scripts/forge/common/enum/ArmorType.gd")

func handle_event(host, event):
	match event:
		States.INIT:
			return States.InitState
		States.NEXT_MENU:
			return _get_next_menu(host)
	return null

func enter(host):
	print("ItemCreationMenu: INITIAL_ITEM_SETUP state entered")
	if PDA.current_state != States.INITIAL_ITEM_SETUP:
		PDA.current_state = States.INITIAL_ITEM_SETUP
		PDA.emit_signal("state_changed", PDA.current_state)
	host.InitialItemSetupMenu.visible = true
	host.ControlMenu.BackButton.disabled = true

func update(host, delta):
	print("ItemCreationMenu: INITIAL_ITEM_SETUP state updating")
	PDA.set_process(false)
	return false

func exit(host):
	print("ItemCreationMenu: INITIAL_ITEM_SETUP state exited")
	host.InitialItemSetupMenu.visible = false
	host.ControlMenu.BackButton.disabled = false

func _get_next_menu(host):
	if !host.item_model.empty():
		var model = host.item_model
		match model.type:
			ItemType.WEAPON:
				match model.weapon_type:
					WeaponType.SWORD:
						return States.SwordStylingMenuState
					WeaponType.AXE:
						pass
					WeaponType.HAMMER:
						pass
			ItemType.ARMOR:
				match model.armor_type:
					ArmorType.HELMET:
						pass
					ArmorType.SHOULDER:
						pass
					ArmorType.CHESTPLATE:
						pass
					ArmorType.GLOVES:
						pass
					ArmorType.BOOTS:
						pass
					ArmorType.PANTS:
						pass