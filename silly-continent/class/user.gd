class_name User extends Object

var name: String
var country: Country

func _init(c: Country):
	set_country(c)

func get_country() -> Country:
	return country

func set_country(c):
	country = c

func has_country() -> bool:
	return get_country() != null
