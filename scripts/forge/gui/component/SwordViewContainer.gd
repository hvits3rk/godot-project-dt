extends MarginContainer

onready var GripTexture = find_node("GripTexture")
onready var GuardTexture = find_node("GuardTexture")
onready var BladeTexture = find_node("BladeTexture")

func _ready():
	pass

func set_grip_resource(res):
	GripTexture.texture = load(res)

func set_guard_resource(res):
	GuardTexture.texture = load(res)

func set_blade_resource(res):
	BladeTexture.texture = load(res)
