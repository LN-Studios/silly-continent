class_name Pirates extends GovtType

var default_data = {
	id = 8,
	name = "pirates"
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func set_effects(c: Country):
	c.get_rep_mod().set_mult(get_name(), -0.07)
	c.get_armyMod().set_mod(get_name(), 0.2)
