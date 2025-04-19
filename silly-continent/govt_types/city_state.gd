extends GovtType

func _ready() -> void:
	set_gtName("City State")

func set_effects(c: Country):
	c.get_approvalMod().set_const(gt_name, .05)
	for t in c.get_territories():
		if (t.is_capital()):
			t.get_popMod().set_const(gt_name, (c.get_territories().size() - 1.0) / 10.0)
		else:
			t.get_popMod().set_const(gt_name, -0.1)

func undo_effects(c: Country):
	c.get_approvalMod().erase(gt_name)
	for t in c.get_territories():
			t.get_popMod().erase(gt_name)
	
