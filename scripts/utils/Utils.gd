extends Node

# Singleton

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