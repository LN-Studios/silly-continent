extends Terrain

var effects = {
	tax = -0.05,
	pop = -0.10
}

func _ready() -> void:
	set_name("Desert")

func set_effects(ty: Territory):
	ty.get_tax_mod().set_mod(get_name(), effects.tax)
	ty.get_pop_pod().set_mod(get_name(), effects.pop)
