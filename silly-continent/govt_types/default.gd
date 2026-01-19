class_name DefaultGovt extends GovtType

var default_data = {
	id = 0,
	name = ""
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func set_effects(c: Country):
	c.get_profit_mod().set_mult(get_name(), -1.0)
