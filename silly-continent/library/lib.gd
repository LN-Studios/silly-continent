class_name Lib extends Object

static var countries = {}
static var govts = {}
static var terrains = {}
static var territs = {}

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

static func add_defaults():
	add_item(Country.new(), countries)
	add_item(GovtType.new(), govts)
	add_item(Terrain.new(), terrains)
	add_item(Territory.new(), territs)
