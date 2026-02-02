class_name PopDecline extends Event


var default_data = {
	id = 3,
	name = "Population Decline",
	description = "Less people are moving into this territory than usual"
}

const duration_min = 3
const duration_max = 5
const profit_max = -0.5
const mult = -0.5

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func can_activate(turn: int) -> bool:
	return (turn > 1 && randi_range(0, 3) == 0)

func activate():
	var target = get_target()
	if (target):
		target.get_pop_mod().set_mult(get_name(), mult, random_duration())

func is_valid(territ: Territory) -> bool:
	return (territ.has_country() && territ.get_profit() < profit_max)

func random_duration() -> int:
	return randi_range(duration_min, duration_max)
