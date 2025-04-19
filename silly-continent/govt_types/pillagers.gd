extends GovtType

func _ready() -> void:
	set_gtName("Pillagers")

func set_effects(c: Country):
	c.get_repMod().set_const(gt_name, -30)
	c.get_armyMod().set_mod(gt_name, 0.2)
