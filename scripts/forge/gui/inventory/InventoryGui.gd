extends MarginContainer

signal inventory_closed

const ItemType = preload("res://scripts/forge/common/enum/ItemType.gd")
const WeaponType = preload("res://scripts/forge/common/enum/WeaponType.gd")
const ArmorType = preload("res://scripts/forge/common/enum/ArmorType.gd")

onready var Inventory = get_node("/root/Forge/Inventory")
onready var CloseButton = find_node("CloseButton")
onready var ItemsContainer = find_node("ItemsContainer")
onready var ItemDetails = find_node("ItemDetails")
onready var DeleteButton = find_node("DeleteButton")

var selected_item_meta

func _ready():
	ItemDetails.visible = false
	CloseButton.connect("pressed", self, "_on_CloseButton_pressed")
	DeleteButton.connect("pressed", self, "_on_DeleteButton_pressed")
	Inventory.connect("item_added", self, "_on_Inventory_item_added")
	Inventory.connect("item_deleted", self, "_on_Inventory_item_deleted")
	ItemsContainer.connect("item_selected", self, "_on_ItemsContainer_item_selected")

func _on_CloseButton_pressed():
	emit_signal("inventory_closed")

func _on_Inventory_item_added(item):
	ItemsContainer.add_item(item)

func _on_Inventory_item_deleted(item):
	ItemsContainer.remove_item_by_id(item.id)
	ItemDetails.visible = false

func _on_DeleteButton_pressed():
	Inventory.remove_item_by_id(selected_item_meta.id)

func _on_ItemsContainer_item_selected(item_meta):
	selected_item_meta = item_meta
	ItemDetails.SwordViewContainer.set_grip_resource(selected_item_meta.texture.grip)
	ItemDetails.SwordViewContainer.set_guard_resource(selected_item_meta.texture.guard)
	ItemDetails.SwordViewContainer.set_blade_resource(selected_item_meta.texture.blade)
	ItemDetails.visible = true
	ItemDetails.NameLabel.text = item_meta.item_name
	ItemDetails.DescriptionLabel.text = item_meta.item_description
	match item_meta.type:
		ItemType.WEAPON:
			ItemDetails.TypeLabel.text = "Weapon"
			match item_meta.weapon_type:
				WeaponType.SWORD:
					ItemDetails.ClassLabel.text = "Sword"
				WeaponType.AXE:
					ItemDetails.ClassLabel.text = "Axe"
				WeaponType.HAMMER:
					ItemDetails.ClassLabel.text = "Hammer"
		ItemType.ARMOR:
			ItemDetails.TypeLabel.text = "Armor"
			match item_meta.armor_type:
				ArmorType.HELMET:
					ItemDetails.ClassLabel.text = "Helmet"
				ArmorType.SHOULDER:
					ItemDetails.ClassLabel.text = "Shoulder"
				ArmorType.CHESTPLATE:
					ItemDetails.ClassLabel.text = "Chestplate"
				ArmorType.GLOVES:
					ItemDetails.ClassLabel.text = "Gloves"
				ArmorType.PANTS:
					ItemDetails.ClassLabel.text = "Pants"
				ArmorType.BOOTS:
					ItemDetails.ClassLabel.text = "Boots"
