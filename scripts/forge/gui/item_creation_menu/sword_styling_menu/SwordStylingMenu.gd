extends VBoxContainer

signal parts_selected

onready var SwordViewContainer = find_node("SwordViewContainer")
onready var StylingTypeControl = find_node("StylingTypeControl")
onready var PommelSelector = find_node("PommelSelector")
onready var GripSelector = find_node("GripSelector")
onready var GuardSelector = find_node("GuardSelector")
onready var BladeSelector = find_node("BladeSelector")

const WeaponPart = preload("res://scripts/forge/common/enum/WeaponPart.gd")

var sword_parts = {}

var selected_parts = {
	pommel = "",
	grip = "",
	guard = "",
	blade = ""
}

func _ready():
	_load_resources_from("res://assets/item/weapon/sword", sword_parts)
	StylingTypeControl.connect("styling_type_selected", self, "_on_StylingTypeControl_styling_type_selected")
	PommelSelector.connect("pommel_selected", self, "_on_PommelSelector_pommel_selected")
	GripSelector.connect("grip_selected", self, "_on_GripSelector_grip_selected")
	GuardSelector.connect("guard_selected", self, "_on_GuardSelector_guard_selected")
	BladeSelector.connect("blade_selected", self, "_on_BladeSelector_blade_selected")
	for res in sword_parts.pommel:
		PommelSelector.add_button("pommel", res)
	for res in sword_parts.grip:
		GripSelector.add_button("grip", res)
	for res in sword_parts.guard:
		GuardSelector.add_button("guard", res)
	for res in sword_parts.blade:
			BladeSelector.add_button("blade", res)
	SwordViewContainer.set_pommel_resource(sword_parts.pommel[0])
	SwordViewContainer.set_grip_resource(sword_parts.grip[0])
	SwordViewContainer.set_guard_resource(sword_parts.guard[0])
	SwordViewContainer.set_blade_resource(sword_parts.blade[0])
	selected_parts.pommel = sword_parts.pommel[0]
	selected_parts.grip = sword_parts.grip[0]
	selected_parts.guard = sword_parts.guard[0]
	selected_parts.blade = sword_parts.blade[0]
	emit_signal("parts_selected", selected_parts)

func _load_resources_from(path, dict = {}, curr_dir = ""):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				dict[file_name] = []
				_load_resources_from(dir.get_current_dir() + "/" + file_name, dict, file_name)
			else:
				if !file_name.ends_with(".import"):
					var resource = dir.get_current_dir() + "/" + file_name
					var texture = load(resource)
					dict[curr_dir].append(resource)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func _on_StylingTypeControl_styling_type_selected(selected_type):
	match selected_type.name:
		"pommel":
			PommelSelector.visible = true
			GripSelector.visible = false
			GuardSelector.visible = false
			BladeSelector.visible = false
		"grip":
			GripSelector.visible = true
			PommelSelector.visible = false
			GuardSelector.visible = false
			BladeSelector.visible = false
		"guard":
			GuardSelector.visible = true
			PommelSelector.visible = false
			GripSelector.visible = false
			BladeSelector.visible = false
		"blade":
			BladeSelector.visible = true
			PommelSelector.visible = false
			GripSelector.visible = false
			GuardSelector.visible = false

func _on_PommelSelector_pommel_selected(pommel_data):
	SwordViewContainer.set_pommel_resource(pommel_data.texture_resource)
	selected_parts.pommel = pommel_data.texture_resource
	emit_signal("parts_selected", selected_parts)

func _on_GripSelector_grip_selected(grip_data):
	SwordViewContainer.set_grip_resource(grip_data.texture_resource)
	selected_parts.grip = grip_data.texture_resource
	emit_signal("parts_selected", selected_parts)

func _on_GuardSelector_guard_selected(guard_data):
	SwordViewContainer.set_guard_resource(guard_data.texture_resource)
	selected_parts.guard = guard_data.texture_resource
	emit_signal("parts_selected", selected_parts)

func _on_BladeSelector_blade_selected(blade_data):
	SwordViewContainer.set_blade_resource(blade_data.texture_resource)
	selected_parts.blade = blade_data.texture_resource
	emit_signal("parts_selected", selected_parts)
