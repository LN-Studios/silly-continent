class_name Republic extends GovtType

var default_data = {
	id = 1,
	name = "republic"
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func set_effects(c: Country):
	c.get_balance_mod().set_mult(get_name(), 0.1)
	c.get_approval_mod().set_mult(get_name(), 0.1)
