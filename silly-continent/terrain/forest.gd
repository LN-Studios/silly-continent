extends Terrain

func _ready() -> void:
	set_name("Forest")
	
func set_effects(ty: Territory):
	#ty.get_tax_mod().set_mod(terrainName, 0.0)
	ty.get_pop_mod().set_mod(get_name(), 0.05)
