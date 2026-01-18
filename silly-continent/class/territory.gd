class_name Territory extends Entity

var pop_change: float

const tax_pop_scale = .0003
const cost_dist_scale = .0001
const cost_pop_scale = .005
const pop_local_econ_scale = 0.1
const pop_natl_econ_scale = 0.15

var territ_data = {
	name = "territory",
	population = 0,
	country_id = 0,
	terrain_id = 0,
}

var mods = {
	profit = ModifierList.new(),
	pop = ModifierList.new(),
}

var profit: float
var node: TerrainNode

func get_size() -> String:
	var size = ""
	var pop_mod = get_pop_mod()
	if (get_population() < 400):	#0-399
		size = "Wilderness"
		pop_mod.set_mult(size, -0.2)
	elif(get_population() < 1000):	#400-999
		size = "Outskirts"
		pop_mod.set_mult(size, -0.1)
	elif(get_population() < 10000):	#1000-9999
		size = "Village"
		pop_mod.set_mult(size, 0.1)
	else: 
		size = "City"				#10,000+
		pop_mod.set_mult(size, 0.2)
	return size.to_lower()

func _init(in_data = {}):
	data.merge(territ_data, true)
	data.merge(in_data, true)
	var terr = data.get("terrain")
	if (terr):
		terr.set_effects(self)
	super(Lib.territs)

##called from country
func turn_phase_z(_turn): 
	set_tax_profit_mod()
	set_economy_pop_mod()

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
func get_pop() -> int:
	return data.get("population", 0)

func get_population() -> int: 
	return get_pop()

func set_population():
	set_economy_pop_mod()
	data.population += get_pop_change()
	if (get_population() < 0): 
		data.population = 0

func get_pop_mod() -> ModifierList: 
	return mods.pop

func get_pop_change() -> float:
	return get_pop_mod().compile()

func set_economy_pop_mod():
	var pop_mod = get_pop_mod()
	pop_mod.set_const("National economy", get_country().get_balance() * pop_natl_econ_scale)
	pop_mod.set_const("Local economy", get_profit() * pop_local_econ_scale)
	
# profit modifiers

func get_profit():
	return profit
	
func set_profit():
	set_tax_profit_mod()
	profit = get_profit_mod().compile()

func get_profit_mod(): 
	return mods.profit	

func set_tax_profit_mod():
	var tax_mod = get_profit_mod()
	tax_mod.set_const("Population", get_population() * tax_pop_scale)
	if (get_country().has_capital()):
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
