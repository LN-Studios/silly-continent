class_name Country extends Node

@export var countryName = ""
@export var color: Color
@export var govtType: GovtType
@export var reputation = 0
@export var approval = 0
@export var capital: Territory

var isCPU = true
var territories: Array[Territory] = [] #territories add themselves
var balance = 0
var profit = 0
var population = 0
var army = 0

var profitMod: Modifier
var repMod: Modifier
var approvalMod: Modifier
var armyMod: Modifier

const army_pop_scale = 0.2 

func _ready() -> void:
	SignalBus.new_turn.connect(_turn)
	profitMod = Modifier.new()
	repMod = Modifier.new()
	approvalMod = Modifier.new()
	armyMod = Modifier.new()
	approvalMod.set_const("Base", 0.5)
	if (!capital): set_capital(get_largest_terr())
	govtType.set_effects(self)
	
func _turn(turn):
	compile_terr_tax()
	set_profit()
	add_balance(profit)
	set_army()

func get_color():
	return color

func get_countryName():
	return countryName
	
func get_govtType():
	if (govtType): return govtType
	
func get_balance(): return balance

#profit
func get_profit(): return profit

func get_profitMod(): return profitMod

func set_profit():
	if (is_unclaimed()): return 0.0
	profit = profitMod.compile()

func compile_pop():
	var total = 0
	for terr in territories:
		total += terr.get_population()
	return total

#population
func get_population():
	population = compile_pop()
	return population
	
func compile_popChange():
	var total = 0
	for terr in territories:
		total += terr.get_popChange()
	return total

func compile_terr_tax():
	var total = 0.0
	for terr in territories:
		total += terr.get_profit()
	profitMod.set_const("Tax", total)
	
# reputation
func get_reputation(): 
	set_reputation()
	return reputation

func set_reputation():
	reputation = repMod.compile()
	if !isCPU:
		SignalBus.new_reputation.emit(reputation, repMod)

func get_repMod(): return repMod
	
#approval
func get_approval(): 
	set_approval()
	return approval

func set_approval():
	approval = approvalMod.compile()
	if !isCPU:
		SignalBus.new_approval.emit(approval, approvalMod)
		
func get_approvalMod(): return approvalMod


#army
func get_army():
	set_army()
	return army

func set_army():
	armyMod.set_const("Population", population * army_pop_scale)
	army = round(armyMod.compile())
	if !isCPU:
		SignalBus.new_army.emit(army, armyMod)

func get_armyMod(): return armyMod

# capital
func get_capital(): 
	return capital

func set_capital(t: Territory):
	if (capital):
		capital.get_popMod().erase("Capital")
	else:
		t.get_popMod().set_mod("Capital", 0.15)
	capital = t

func set_CPU(val):
	isCPU = val
	
func add_balance(new):
	balance += new
	if !isCPU && new != 0 :
		SignalBus.new_balance.emit(balance, profitMod)

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
	return get_govtType().get_gtName() == "Unclaimed"
	
func mod_purge(name: String):
	profitMod.erase(name)
	approvalMod.erase(name)
	repMod.erase(name)
	armyMod.erase(name)
