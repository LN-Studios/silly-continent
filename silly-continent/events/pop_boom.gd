class_name PopBoom extends Event


var default_data = {
	id = 2,
	name = "Population Boom",
	description = "The word has spread that this territory is the place to be!"
}

const duration_min = 3
const duration_max = 5
const pop_threshold = 1000
const mult = 0.5

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func can_activate(_turn: int) -> bool:
	return (randi_range(0, 3) == 0)

func activate():
	var valid_territs = Filter.filter_array(Lib.territs.values(), is_valid)
	var target = Filter.select_random(valid_territs)
	print("%s has a %s" % [target.get_name(), get_name()])
	target.get_pop_mod().set_mult(get_name(), mult, random_duration())

func is_valid(territ: Territory) -> bool:
	return (territ.has_country() && territ.get_pop() >= pop_threshold)

func random_duration() -> int:
	return randi_range(duration_min, duration_max)
