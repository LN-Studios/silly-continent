class_name Lib extends Object

static var countries = {}
static var govts = {}
static var terrains = {}
static var territs = {}

static var Dicts = {
	Countries = countries,
	Govts = govts,
	Terrains = terrains,
	Territs = territs,
}

static func add_item(item: Entity, dict: Dictionary, overwrite = false):
	var key = item.data.name
	if dict.has(key):
		print("WARNING: %s already in lib" % key)
		if (!overwrite): return
	dict[item.get_id()] = item

static func get_item(id: int, dict: Dictionary) -> Entity:
	var item = dict.get(id, null)
	if (!item):
		print("Entity with ID %d not found" % id)
	return item

static func get_country(id):
	return get_item(id, countries)

static func get_govt(id):
	return get_item(id, govts)

static func get_terrain(id):
	return get_item(id, terrains)

static func get_territ(id):
	return get_item(id, territs)

##creates a default of each entity
static func add_defaults():
	add_item(Country.new(), countries)
	add_item(GovtType.new(), govts)
	add_item(Terrain.new(), terrains)
	add_item(Territory.new(), territs)

static func get_entity_save_path(dict_name: String) -> String:
	return FileUtil.get_save_path() + "/%s" % dict_name + FileUtil.ext

static func save_state():
	for dict_name in Dicts.keys():
		var entity_data_arr = []
		for entity in Dicts[dict_name].values():
			entity_data_arr.append(entity.get_data())
		FileUtil.write_to_file(entity_data_arr, get_entity_save_path(dict_name))

static func load_state():
	for dict_name in Dicts.keys():
		var entities_arr = FileUtil.read_from_file(get_entity_save_path(dict_name))
		#forgive me for using a match statement here :(
		match dict_name:
			"Countries": load_countries(entities_arr)
			"Govts": load_govt_types(entities_arr)
			"Terrains": load_terrains(entities_arr)
			"Territs": load_territories(entities_arr)

static func load_countries(entity_arr: Array):
	for entity_data in entity_arr:
		add_item(Country.new(entity_data), countries)

static func load_govt_types(entity_arr: Array):
	for entity_data in entity_arr:
		add_item(GovtType.new(entity_data), govts)

static func load_terrains(entity_arr: Array):
	for entity_data in entity_arr:
		add_item(Terrain.new(entity_data), terrains)

static func load_territories(entity_arr: Array):
	for entity_data in entity_arr:
		add_item(Territory.new(entity_data), territs)
