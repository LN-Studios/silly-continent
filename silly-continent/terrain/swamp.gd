extends Terrain

func _ready() -> void:
	set_terrainName("Swamp")

func set_effects(t:Territory):
	t.get_taxMod().set_mod(terrainName, -0.05)
