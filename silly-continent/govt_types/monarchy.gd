extends GovtType

func _ready() -> void:
	set_gtName("Monarchy")

func set_effects(c: Country):
	c.get_approvalMod().set_const(gt_name, -0.05)
	c.get_armyMod().set_mod(gt_name, 0.1)
