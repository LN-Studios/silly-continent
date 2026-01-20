class_name DefaultTerrain extends Terrain

var default_data = {
	id = 0,
	name = "default terrain",
	effects = {
		tax = 0.0,
		pop = 0.0
	},
}

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

