class_name ModifierList extends Object

var consts = []
var mults = []

## adds consts together, then adds mults together separately, then multiplies the two
func compile():
	var val = 0.0
	for con in consts:
		val += con.get_value()
	var mult_val = 0.0
	for mult in mults:
		mult_val += mult.get_value()
	return val * (mult_val + 1)
	
func get_consts(): return consts

func get_mults(): return mults

func set_const(name: String, value: float, duration = -1): 
	var mod = Modifier.new(mults, name, value, duration)
	add_mod(consts, mod)

func set_mult(name: String, value: float, duration = -1): 
	var mod = Modifier.new(mults, name, value, duration)
	add_mod(mults, mod)

## makes a const modifier with a duration of 1
func set_event(name: String, value: float):
	set_const(name, value, 1)

func add_mod(arr: Array, mod: Modifier):
	if (is_zero_approx(mod.get_value())):
		return
	var dupe_mod: Modifier
	for current_mod in arr:
		if (current_mod.get_name() == mod.get_name()):
			dupe_mod = current_mod
			break
	if (dupe_mod != null):
		arr.erase(dupe_mod)
	arr.append(mod)

## returns a list of all consts and mults as a string separated by \n
func get_list(use_money: bool) -> String:
	var str = ""
	if (use_money):
		for con in consts:
			str += con.get_name().capitalize() + ": $" + Main.format_float(con.get_value()) + "\n"
	else:
		for con in consts:
			str += con.get_name().capitalize() + ": "
			if con.get_value() > 0.0: str += "+"
			str += Main.format_float(con.get_value()) + "\n"
	for mult in mults:
		str += mult.get_name().capitalize() + ": "
		var pct = mult.get_value()
		if pct > 0.0: str += "+"
		str += Main.format_percent(pct) + "\n"
	return str

func set_tooltip(label: Label, useMoney: bool):
	label.tooltip_text = get_list(useMoney)

func erase(val):
	consts.erase(val)
	mults.erase(val)

func contains(mod: Modifier):
	return consts.has(mod) || mults.has(mod)
