extends GovtType

func _ready() -> void:
	set_gtName("Unclaimed")

func set_effects(c: Country):
	c.get_profitMod().set_mod(gt_name, -1.0)
