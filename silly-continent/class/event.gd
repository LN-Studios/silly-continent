class_name Event extends Entity

func _init(_in_data = {}):
	SignalBus.turn_phase_m.connect(new_turn)
	super({})

func new_turn(turn: int):
	if (can_activate(turn)):
		activate()

func can_activate(_turn: int) -> bool:
	return false

func activate():
	pass

func get_target() -> Territory:
	var valid_territs = Filter.filter_array(Lib.territs.values(), is_valid)
	var target = Filter.select_random(valid_territs)
	if (target): print("%s has a %s" % [target.get_name(), get_name()])
	return target

func is_valid(_territ: Territory) -> bool:
	return false
