class_name Theocracy extends GovtType

var default_data = {
	id = 7,
	name = "theocracy"
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func set_effects(c: Country):
	c.get_balance_mod().set_mult(get_name(), 0.1)
	c.get_rep_mod().set_mult(get_name(), 0.05)
	c.get_army_mod().set_mod(get_name(), 0.1)
