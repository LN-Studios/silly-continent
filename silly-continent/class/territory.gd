class_name Territory extends Entity

var pop_change: float

const tax_pop_scale = .0003
const cost_dist_scale = .0001
const cost_pop_scale = .005
const pop_local_econ_scale = 0.1
const pop_natl_econ_scale = 0.15

var node: TerrainNode

var territ_data = {
	name = "territory",
	population = 0,
	country_id = 0,
	terrain_id = 0,
}

var mods = {
	tax = Modifier.new(),
	pop = Modifier.new(),
}

func get_size():
	var size = ""
	var pop_mod = get_pop_mod()
	if (get_population() < 250):	#0-249
		size = "Wilderness"
		pop_mod.set_mod(size, -0.2)
	elif(get_population() < 1000):	#250-999
		size = "Outskirts"
		pop_mod.set_mod(size, -0.1)
	elif(get_population() < 10000):	#1000-9999
		size = "Village"
		pop_mod.set_mod(size, 0.1)
	else: 
		size = "City"				#10,000+
		pop_mod.set_mod(size, 0.2)
	return size.to_lower()

func _init(in_data = {}):
	data.merge(territ_data, true)
	data.merge(in_data, true)
	var terr = data.get("terrain")
	if (terr):
		terr.set_effects(self)
	super(Lib.territs)
	
func _turn(turn): 
	set_population()

func connect_entities():
	data.country = Lib.get_country(data.country_id)
	data.terrain = Lib.get_terrain(data.terrain_id)
	
func get_name() -> String: 
	return data.name

func get_terrain() -> Terrain: 
	return data.terrain

func get_terrain_name() -> String:
	return get_terrain().get_name()

func get_country() -> Country: 
	return data.get("country", null)

# population modifiers
func get_pop_mod() -> Modifier: 
	return mods.pop

func get_pop() -> int:
	return data.get("population", 0)

func get_population() -> int: 
	return get_pop()
	
func get_pop_change(): 
	return get_pop_mod().compile()

func set_population():
	var pop_mod = get_pop_mod()
	pop_mod.set_const("National economy", get_country().get_profit() * pop_natl_econ_scale if has_country() else 0)
	pop_mod.set_const("Local economy", get_profit() * pop_local_econ_scale)
	data.population += pop_mod.compile()
	if get_population() < 0: 
		data.population = 0

# tax modifiers
func get_tax_mod(): 
	return mods.tax

func get_profit():
	set_tax()
	return get_tax_mod().compile()
	
func set_tax():
	var tax_mod = get_tax_mod()
	tax_mod.set_const("Population", get_population() * tax_pop_scale)
	tax_mod.set_const("Distance to capital", -(get_capital_distance() * cost_dist_scale * (get_population() * cost_pop_scale)))

func get_position(): 
	return node.get_position()

func get_capital_distance():
	if (!has_country()): return 0
	return get_position().distance_to(get_country().get_capital().get_position())
	
func set_country(c):
	node.set_country_color(c)
	data.country = c
	if (c):
		c.add_terr(self)
	
func has_country() -> bool:
	if (get_country() == null): return false
	return get_country().is_unclaimed()
	
func is_capital() -> bool:
	if (!has_country()): return false
	return get_country().get_capital() == self
	
func mod_purge(effect_name: String):
	for mod in mods:
		mod.erase(effect_name)
		
#events
func spawn_exodus(rate):
	get_pop_mod().set_const("Spawn Exodus", rate)

func end_spawn_exodus():
	get_pop_mod().get_consts().erase("Spawn Exodus")
