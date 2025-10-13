extends GovtType

func _ready() -> void:
	set_gtName("Theocracy")

func set_effects(c: Country):
	c.get_profitMod().set_mod(gt_name, 0.1)
	c.get_rep_mod().set_const(gt_name, 5)
	c.get_armyMod().set_mod(gt_name, 0.1)
