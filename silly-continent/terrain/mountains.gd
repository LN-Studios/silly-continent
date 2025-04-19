extends Terrain

func _ready() -> void:
	set_terrainName("Mountain")

func set_effects(t:Territory):
	t.get_taxMod().set_mod(terrainName, -0.15)
	t.get_popMod().set_mod(terrainName, -0.1)
