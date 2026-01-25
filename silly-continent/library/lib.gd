extends Node

var countries = {}
var govts = {}
var terrains = {}
var territs = {}

var load_dicts = {
	Countries = countries,
	#Govts = govts,
	#Terrains = terrains,
	Territs = territs,
}

var govt_arr = [
	DefaultGovt.new(),
	Republic.new(),
	Monarchy.new(),
	CityState.new(),
	Nomads.new(),
	Pillagers.new(),
	Theocracy.new(),
	Pirates.new()
]

var terriain_arr = [
	DefaultTerrain.new(),
	Grassland.new(),
	Forest.new(),
	Coastal.new(),
	Hills.new(),
	Mountains.new(),
	Desert.new(),
	Swamp.new()
]

var event_arr = [
	SpawnExodus.new(),
	PopBoom.new()
]

func add_item(item: Entity, dict: Dictionary, overwrite = false):
	var key = item.get_id()
	if dict.has(key):
		print("WARNING: %s already in lib" % key)
		if (!overwrite): return
	dict[key] = item

func get_item(id: int, dict: Dictionary) -> Entity:
	var item = dict.get(id, null)
	if (!item):
		print("Entity with ID %d not found" % id)
	return item

func has_item(id: int, dict: Dictionary) -> bool:
	return dict.has(id)

func get_country(id) -> Country:
	return get_item(id, countries)

func get_govt(id) -> GovtType:
	return get_item(id, govts)

func get_terrain(id) -> Terrain:
	return get_item(id, terrains)

func get_territ(id) -> Territory:
	return get_item(id, territs)

##creates a default of each entity
func add_defaults():
	add_item(Country.new(), countries)
	add_item(GovtType.new(), govts)
	add_item(Terrain.new(), terrains)
	add_item(Territory.new(), territs)

func get_entity_save_path(dict_name: String) -> String:
	return FileUtil.get_save_path() + "/%s" % dict_name + FileUtil.save_ext

func get_entity_load_path(dict_name: String) -> String:
	return FileUtil.get_save_path() + "/%s" % dict_name + FileUtil.json_ext

func save_state():
	for dict_name in load_dicts.keys():
		var entity_data_arr = []
		for entity in load_dicts[dict_name].values():
			entity_data_arr.append(entity.get_data())
		FileUtil.write_to_file(entity_data_arr, get_entity_save_path(dict_name))

func load_state():
	for dict_name in load_dicts.keys():
		var entities_arr = FileUtil.read_from_file(get_entity_load_path(dict_name))
		#forgive me for using a match statement here :(
		match dict_name:
			"Countries": load_countries(entities_arr)
			"Territs": load_territories(entities_arr)
			"Govts": load_govt_types(entities_arr)
			"Terrains": load_terrains(entities_arr)
	for govt_type in govt_arr:
		add_item(govt_type, govts)
	for terrain in terriain_arr:
		add_item(terrain, terrains)

func load_countries(entity_arr: Array):
	for entity_data in entity_arr:
		add_item(Country.new(entity_data), countries)

func load_govt_types(entity_arr: Array):
	for entity_data in entity_arr:
		add_item(GovtType.new(entity_data), govts)

func load_terrains(entity_arr: Array):
	for entity_data in entity_arr:
		add_item(Terrain.new(entity_data), terrains)

func load_territories(entity_arr: Array):
	for entity_data in entity_arr:
		add_item(Territory.new(entity_data), territs)
