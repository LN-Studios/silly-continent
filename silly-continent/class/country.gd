class_name Country extends Object


var data = {
	name = "country",
	color = Color.WHITE,
	govt = null,
	reputation = 0,
	approval = 0,
	capital = null,
	is_cpu = true,
	balance = 0,
	profit = 0,
	population = 0,
	army = 0,
}

var mods = {
	profit = Modifier.new(),
	reputation = Modifier.new(),
	approval = Modifier.new(),
	army = Modifier.new(),
}

var territories: Array[Territory] = [] #territories add themselves

const army_pop_scale = 0.2 

func _ready():
	SignalBus.new_turn.connect(_turn)
	mods.approval.set_const("Base", 0.5)
	if (!get_capital()): set_capital(get_largest_terr())
	get_govt().set_effects(self)
	
func _turn(turn):
	compile_terr_tax()
	set_profit()
	add_balance(get_profit())
	set_army()

func get_color():
	return data.color

func get_name():
	return data.name
	
func get_govt():
	return data.govt
	
func get_balance(): 
	return data.balance

func is_cpu():
	return data.is_cpu()

#profit
func get_profit(): 
	return data.profit

func get_profit_mod(): 
	return mods.profit

func set_profit():
	if (is_unclaimed()): return 0.0
	data.profit = get_profit_mod().compile()

#population
func get_population():
	data.population = compile_pop()
	return data.population

func compile_pop():
	var total = 0
	for terr in territories:
		total += terr.get_population()
	return total
	
func compile_pop_change():
	var total = 0
	for terr in territories:
		total += terr.get_popChange()
	return total

func compile_terr_tax():
	var total = 0.0
	for terr in territories:
		total += terr.get_profit()
	get_profit_mod().set_const("Tax", total)
	
# reputation
func get_reputation(): 
	set_reputation()
	return data.reputation

func set_reputation():
	data.reputation = get_rep_mod().compile()
	if !is_cpu():
		SignalBus.new_reputation.emit(get_reputation(), get_rep_mod())

func get_rep_mod(): 
	return data.reputation

func get_reputation_mod():
	return get_rep_mod()
	
#approval
func get_approval(): 
	set_approval()
	return data.approval

func set_approval():
	data.approval = get_approval_mod().compile()
	if !is_cpu():
		SignalBus.new_approval.emit(data.approval, get_approval_mod())
		
func get_approval_mod(): 
	return mods.approval

#army
func get_army():
	set_army()
	return data.army

func set_army():
	get_army_mod().set_const("Population", get_population() * army_pop_scale)
	data.army = round(get_army_mod().compile())
	if !is_cpu():
		SignalBus.new_army.emit(data.army, get_army_mod())

func get_army_mod(): 
	return mods.army

# capital
func get_capital(): 
	return data.capital

func set_capital(t: Territory):
	if (get_capital()):
		data.capital.get_pop_mod().erase("Capital")
	else:
		t.get_pop_mod().set_mod("Capital", 0.15)
	data.capital = t

func set_CPU(val: bool):
	data.is_cpu = val
	
func add_balance(new):
	data.balance += new
	if !is_cpu() && new != 0 :
		SignalBus.new_balance.emit(data.balance, get_profit_mod())

func add_terr(terr: Territory):
	territories.append(terr)

func get_territories():
	return territories

func get_largest_terr():
	var largest: Territory
	for terr in territories:
		if (!largest || terr.get_population() > largest.get_population()):
			largest = terr
	return largest

func is_unclaimed():
	return get_govt().get_gtName() == "Unclaimed"
	
func mod_purge(name: String):
	for mod in mods:
		mod.erase(name)
