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
