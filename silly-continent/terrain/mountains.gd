class_name Mountains extends Terrain

var default_data = {
	id = 5,
	name = "mountains",
	effects = {
		tax = -0.15,
		pop = -0.1
	},
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)
