class_name Pillagers extends GovtType

var default_data = {
	id = 5,
	name = "pillagers"
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func set_effects(c: Country):
	c.get_rep_mod().set_mult(get_name(), -0.1)
	c.get_army_mod().set_mult(get_name(), 0.2)
