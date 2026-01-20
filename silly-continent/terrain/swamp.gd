class_name Swamp extends Terrain

var default_data = {
	id = 7,
	name = "swamp",
	effects = {
		tax = -0.05,
		pop = 0.0
	},
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)
