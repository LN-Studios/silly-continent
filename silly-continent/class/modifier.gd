class_name Modifier extends Object

var mod_arr: Array
var name: String
var value: float
var duration = -1

func _init(new_arr: Array, new_name: String, new_value: float, new_duration = -1):
	SignalBus.turn_phase_m.connect(turn_phase_m)
	mod_arr = new_arr
	name = new_name
	value = new_value
	duration = new_duration

func get_name() -> String:
	return name

func get_value() -> float:
	return value

func get_duration() -> int:
	return duration

func turn_phase_m(turn):
	if (turn == 0):
		pass
	duration -= 1
	if (duration == 0):
		remove_modifier()

func remove_modifier():
	mod_arr.erase(self)

func is_infinite() -> bool:
	return (duration < 0)
