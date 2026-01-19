class_name Monarchy extends GovtType

var default_data = {
	id = 2,
	name = "monarchy"
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func set_effects(c: Country):
	c.get_approval_mod().set_mult(get_name(), -0.05)
	c.get_armyMod().set_mult(get_name(), 0.1)