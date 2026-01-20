class_name Country extends Entity

var country_data = {
	name = "country",
	color_rgb = [0, 0, 0],
	capital_id = 0,
	govt_id = 0,
	reputation = 0,
	approval = 0,
	balance = 0,
	army = 0,
	is_cpu = true,
}

var mods = {
	balance = ModifierList.new(),
	reputation = ModifierList.new(),
	approval = ModifierList.new(),
	army = ModifierList.new(),
}

var territories: Array[Territory] = [] #territories add themselves
var color: Color = Color.BLACK
var population = 0

const army_pop_scale = 0.2 

func _init(in_data = {}):
	data.merge(country_data, true)
	data.merge(in_data, true)
	#if (!get_capital()): set_capital(get_largest_terr())
	#get_govt().set_effects(self)
	super(Lib.countries)

func connect_entities():
	data.capital = Lib.get_territ(data.capital_id)
	set_govt(Lib.get_govt(data.govt_id))
	color = ColorUtil.format_rgb(get_color_rgb())

func entities_connected():
	set_population()
	
	compile_terr_tax(true)
	compile_pop_change(true)
	
func turn_phase_a(_turn):
	set_balance()
	set_reputation()
	set_approval()
	set_army()
	set_population()

func turn_phase_t(_turn):
	compile_terr_tax(true)
	compile_pop_change(true)

func get_color() -> Color:
	return color

func get_color_rgb() -> Array:
	return data.color_rgb

func get_name() -> String:
	return data.name
	
func get_govt() -> GovtType:
	return data.get("govt", null)

func set_govt(new_govt: GovtType):
	if (get_govt()):
		get_govt().remove_effects(self)
	data.govt = new_govt
	new_govt.set_effects(self)

func is_cpu() -> bool:
	return data.is_cpu

#balance
func get_balance(): 
	return data.balance

func get_balance_mod(): 
	return mods.balance

func set_balance():
	if (is_unclaimed()): 
		data.balance = 0.00
	else:
		data.balance += get_balance_mod().compile()

func compile_terr_tax(set_tax = false):
	var total = 0.0
	for terr in territories:
		if (set_tax):
			terr.set_profit()
		total += terr.get_profit()
	get_balance_mod().set_const("Tax", total)

#population
func get_population() -> int:
	return population

func set_population():
	population = compile_pop(true)

func compile_pop(set_pop = false) -> int:
	var total = 0
	for terr in get_territories():
		if (set_pop):
			terr.set_population()
		total += terr.get_population()
	return total
	
func compile_pop_change(set_change = false) -> int:
	var total = 0
	for terr in get_territories():
		if (set_change):
			terr.set_economy_pop_mod()
		total += terr.get_pop_change()
	return round(total)
	
# reputation
func get_reputation(): 
	return data.reputation

func set_reputation():
	data.reputation += get_rep_mod().compile()

func get_rep_mod(): 
	return mods.reputation

func get_reputation_mod():
	return get_rep_mod()
	
#approval
func get_approval() -> int: 
	return round(data.approval)

func set_approval():
	data.approval += get_approval_mod().compile()
	if (get_approval() > 100):
		data.approval = 100
		
func get_approval_mod(): 
	return mods.approval

#army
func get_army():
	return data.army

func set_army():
	data.army += round(get_army_mod().compile())

func get_army_mod(): 
	return mods.army

# capital
func get_capital(): 
	return data.capital

func set_capital(t: Territory):
	if (has_capital()):
		get_capital().get_pop_mod().erase("Capital")
	else:
		t.get_pop_mod().set_mult("Capital", 0.15)
	data.capital = t

func has_capital() -> bool:
	return get_capital() != null

func set_CPU(val: bool):
	data.is_cpu = val

func add_terr(terr: Territory):
	territories.append(terr)

func get_territories() -> Array:
	return territories

func get_largest_terr():
	var largest: Territory
	for terr in territories:
		if (!largest || terr.get_population() > largest.get_population()):
			largest = terr
	return largest

func is_unclaimed():
	return get_id() == 1
	
func mod_purge(name: String):
	for mod in mods:
		mod.erase(name)
