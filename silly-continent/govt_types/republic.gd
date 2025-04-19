extends GovtType

func _ready() -> void:
	set_gtName("Republic")

func set_effects(c: Country):
	c.get_profitMod().set_mod(gt_name, 0.1)
	c.get_approvalMod().set_const(gt_name, 0.1)
