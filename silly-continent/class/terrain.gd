class_name Terrain extends Entity

var terrain_data = {
	name = "terrain",
	effects = {
		tax = 0.0,
		pop = 0.0
	},
}
	
func _init(_in_data = {}):
	#data.merge(terrain_data, true)
	#data.merge(in_data, true)
	super({})

func set_effects(ty: Territory):
	ty.get_profit_mod().set_mult(get_name(), data.effects.tax)
	ty.get_pop_mod().set_mult(get_name(), data.effects.pop)
