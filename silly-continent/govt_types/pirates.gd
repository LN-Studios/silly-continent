extends GovtType

func _ready() -> void:
	set_gtName("Pirates")

func set_effects(c: Country):
	c.get_rep_mod().set_const(gt_name, -15)
	c.get_armyMod().set_mod(gt_name, 0.2)
