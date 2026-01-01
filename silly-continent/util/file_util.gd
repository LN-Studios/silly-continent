class_name FileUtil extends Object

const data_path = "res://data"
const default_name = "default"
var default_path = "%s/%s" % [data_path, default_name]
const SAVE_ID = "save_"
const BACKUP_EXT = "_backup"
var save_path = default_path

func open_file(path = save_path, write = true) -> FileAccess:
	var flag = FileAccess.WRITE if (write) else FileAccess.READ
	var file = FileAccess.open(path, flag)
	if (!file): 
		print("File not found: %s" % path)
		file = FileAccess.open(path, FileAccess.WRITE)
		file.store_string(".")
		file = open_file(path, write)
	return file

func write_to_file(content: Variant, path: String = save_path):
	var data = JSON.stringify(content)
	var file = open_file(path, true)
	file.store_string(data)

func read_from_file(path: String = save_path) -> Variant:
	var file = open_file(path, false)
	var content = file.get_as_text()
	var json = JSON.new()
	if json.parse(content) != OK:
		print("JSON Parse Error: " + json.get_error_message() + " in " + content)
		return
	var data = json.data
	return data

func do_each_line(action: Callable, path: String = save_path, limit = -1):
	var file = open_file(path, false)
	if (!file): print("Failed to open %s" + path)
	var reps = 0
	while (file.get_position() < file.get_length() && reps > limit):
		var line = file.get_line()
		action.call(line)
		reps += 1
		#Err.print("/ " + str(reps))

## set save path to res://data/`file_name`
## if left blank, sets to default
func set_save_path(file_name = ""):
	if (file_name.is_empty()):
		file_name = default_name
	#save_path = "%s/%s" % [data_path, save_dir_name(file_name)]
	print("/ save path: %s" % save_path)

func save_dir_exists(create_if_not = false) -> bool:
	return false
	#var dirs = get_save_dirs()
	#var dir_name = save_dir_name()
	#var has_dir = dirs.has(dir_name)
	#if (!has_dir && create_if_not):
	#	set_save_path(dir_name)
	#	create_dir(save_path)
	#return has_dir

func write_config(config: ConfigFile, path: String):
	var result = config.save(path)
	if (result != OK): 
		print("Error saving config file: error code %d" % result)

func create_dir(path: String):
	var error = DirAccess.make_dir_recursive_absolute(path)
	if (error != OK): 
		print("Error creating dir: error code %d" % error)

##absolute paths
func copy_file(from: String, to: String):
	var error = DirAccess.copy_absolute(from, to)
	if (error != OK):
		print("Error copying file: error code %d" % error)

func on_default() -> bool:
	return (default_path == save_path)
