class_name Hills extends Terrain

var default_data = {
	id = 4,
	name = "hills",
	effects = {
		tax = -0.1,
		pop = 0.0
	},
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)
