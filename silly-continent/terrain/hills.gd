extends Terrain

func _ready() -> void:
	set_name("Hills")

func set_effects(ty:Territory):
	ty.get_tax_mod().set_mod(get_name(), -0.1)
