class_name Terrain extends Entity

var terrain_data = {
	name = "terrain"
}
	
func _init(in_data = {}):
	data.merge(terrain_data, true)
	data.merge(in_data, true)
	super(Lib.terrains)

func set_effects(_ty: Territory):
	pass
