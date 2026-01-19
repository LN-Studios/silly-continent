class_name Grassland extends Terrain

var default_data = {
	id = 1,
	name = "grassland",
	effects = {
		tax = 0.15,
		pop = 0.0
	},
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)
