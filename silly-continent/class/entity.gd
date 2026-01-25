class_name Entity extends Object

var data = {
	id = 0,
	name = "blank entity"
}

func _init(_lib_dict: Dictionary):
	SignalBus.turn_phase_a.connect(turn_phase_a)
	SignalBus.turn_phase_m.connect(turn_phase_m)
	SignalBus.turn_phase_t.connect(turn_phase_t)
	SignalBus.turn_phase_z.connect(turn_phase_z)
	SignalBus.finish_loading.connect(connect_entities)
	SignalBus.entities_connected.connect(entities_connected)

#phase a: new values are compiled/set
#phase m: modifiers are removed
#phase z: modifiers are set

func turn_phase_a(_turn):
	pass

func turn_phase_m(_turn):
	pass

func turn_phase_t(_turn):
	pass

func turn_phase_z(_turn):
	pass

func connect_entities():
	pass

func entities_connected():
	pass
	
func get_id() -> int:
	return data.id

func get_name() -> String:
	return data.get("name", "name not found")

func get_data() -> Dictionary:
	return data

func get_description(alt_desc = "no description provided") -> String:
	return data.get("description", alt_desc)
