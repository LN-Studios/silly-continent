class_name Nomads extends GovtType

var default_data = {
	id = 4,
	name = "nomads"
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func set_effects(c: Country):
	c.get_balance_mod().set_mult("Nomads", -0.15)
	c.get_army_mod().set_mult(get_name(), 0.5)
