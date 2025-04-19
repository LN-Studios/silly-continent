class_name GovtType extends Node

var gt_name: String

func get_gtName():
	return gt_name

func set_gtName(name):
	gt_name = name
	
func set_effects(c: Country):
	pass
	
func switch_type(c: Country, new: GovtType):
	var old = self
	c.mod_purge(old)
	c.set_govtType(new)
