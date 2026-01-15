class_name Entity extends Object

var data = {
	id = 0,
	name = "blank entity"
}

func _init(lib_dict: Dictionary):
	SignalBus.new_turn.connect(_turn)
	SignalBus.finish_ready.connect(connect_entities)
	Lib.add_item(self, lib_dict)

func _turn(_turn_number):
	pass

func connect_entities():
	pass
	
func get_id() -> int:
	return data.id

func get_name() -> String:
	return data.get("name", "name not found")

func get_data() -> Dictionary:
	return data