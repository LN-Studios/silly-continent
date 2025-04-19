extends Terrain

func _ready() -> void:
	set_terrainName("")

func set_effects(t:Territory):
	t.get_taxMod().set_mod(terrainName, 0.0)
	t.get_popMod().set_mod(terrainName, 0.0)
