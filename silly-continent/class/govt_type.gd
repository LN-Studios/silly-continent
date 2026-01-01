class_name GovtType extends Entity

var govt_data = {
	name = "govt type"
}

func _init(in_data = {}):
	data.merge(govt_data, true)
	data.merge(in_data, true)
	super(Lib.govts)
	
func set_effects(c: Country):
	pass
	
func switch_type(c: Country, new: GovtType):
	var old = self
	c.mod_purge(old)
	c.set_govtType(new)
