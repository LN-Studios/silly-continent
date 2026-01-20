class_name Forest extends Terrain


var default_data = {
	id = 2,
	name = "forest",
	effects = {
		tax = 0.0,
		pop = 0.05
	},
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)
