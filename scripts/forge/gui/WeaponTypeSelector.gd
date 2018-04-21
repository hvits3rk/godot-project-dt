extends HBoxContainer

signal weapon_type_chosen

onready var SwordButton = get_node("Sword")
onready var AxeButton = get_node("Axe")
onready var HammerButton = get_node("Hammer")

const WeaponType = preload("res://scripts/forge/common/enum/WeaponType.gd")

func _ready():
	SwordButton.connect("pressed", self, "_on_SwordButton_pressed")
	AxeButton.connect("pressed", self, "_on_AxeButton_pressed")
	HammerButton.connect("pressed", self, "_on_HammerButton_pressed")

func _on_SwordButton_pressed():
	emit_signal("weapon_type_chosen", WeaponType.SWORD)

func _on_AxeButton_pressed():
	emit_signal("weapon_type_chosen", WeaponType.AXE)

func _on_HammerButton_pressed():
	emit_signal("weapon_type_chosen", WeaponType.HAMMER)
