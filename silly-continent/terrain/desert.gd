class_name Desert extends Terrain

var default_data = {
	id = 6,
	name = "desert",
	effects = {
		tax = -0.05,
		pop = -0.10
	},
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)
