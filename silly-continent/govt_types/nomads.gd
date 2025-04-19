extends GovtType

func _ready() -> void:
	set_gtName("Nomads")

func set_effects(c: Country):
	c.get_profitMod().set_mod("Nomads", -0.15)
	c.get_armyMod().set_mod(gt_name, 0.5)
