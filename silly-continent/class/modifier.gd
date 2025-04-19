class_name Modifier extends Node

const main = preload("res://main/main.gd")

var consts = {}
var mods = {}

# adds consts together, then adds mods together separately, then multiplies the two
func compile():
	var val = 0.0
	for con in consts.keys():
		val += consts[con]
	var modVal = 0.0
	for mod in mods.keys():
		modVal += mods[mod]
	return val * (modVal + 1)
	
func get_consts(): return consts

func set_const(name, val): consts[name] = val

func get_mods(): return mods

func set_mod(name, val): mods[name] = val

#returns a list of all consts and mods as a string
func get_list(useMoney: bool):
	var str = ""
	if (useMoney):
		for con in consts.keys():
			str += con + ": $" + main.format_float(consts[con]) + "\n"
	else:
		for con in consts.keys():
			str += con + ": "
			if consts[con] > 0.0: str += "+"
			str += main.format_float(consts[con]) + "\n"
	for mod in mods.keys():
		str += mod + ": "
		var pct = mods[mod]
		if pct > 0.0: str += "+"
		str += main.format_percent(pct) + "\n"
	return str

func set_tooltip(label: Label, useMoney: bool):
	label.tooltip_text = get_list(useMoney)

func erase(val):
	consts.erase(val)
	mods.erase(val)

func contains(val):
	return consts.has(val) || mods.has(val)
