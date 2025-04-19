extends Terrain

func _ready() -> void:
	set_terrainName("Coastal")

func set_effects(t: Territory):
	t.get_taxMod().set_mod(terrainName, 0.05)
	t.get_popMod().set_mod(terrainName, 0.05)
