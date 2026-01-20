class_name CityState extends GovtType

var default_data = {
	id = 3,
	name = "city-state"
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func set_effects(c: Country):
	c.get_approval_mod().set_mult(get_name(), .05)
	for t in c.get_territories():
		if (t.is_capital()):
			t.get_pop_mod().set_const(get_name(), (c.get_territories().size() - 1.0) / 10.0)
		else:
			t.get_pop_mod().set_const(get_name(), -0.1)

func undo_effects(c: Country):
	c.get_approval_mod().erase(get_name())
	for t in c.get_territories():
			t.get_pop_mod().erase(get_name())
	
