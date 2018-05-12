extends MarginContainer

onready var PommelTexture = find_node("PommelTexture")
onready var GripTexture = find_node("GripTexture")
onready var GuardTexture = find_node("GuardTexture")
onready var BladeTexture = find_node("BladeTexture")

func _ready():
	pass

func set_pommel_resource(res):
	PommelTexture.texture = load(res)

func set_grip_resource(res):
	GripTexture.texture = load(res)

func set_guard_resource(res):
	GuardTexture.texture = load(res)

func set_blade_resource(res):
	BladeTexture.texture = load(res)
