extends Terrain

func _ready() -> void:
	set_name("Mountain")

func set_effects(ty:Territory):
	ty.get_tax_mod().set_mod(get_name(), -0.15)
	ty.get_pop_mod().set_mod(get_name(), -0.1)
