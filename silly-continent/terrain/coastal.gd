class_name Coastal extends Terrain

var default_data = {
	id = 3,
	name = "coastal",
	effects = {
		tax = 0.05,
		pop = 0.05
	},
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)
