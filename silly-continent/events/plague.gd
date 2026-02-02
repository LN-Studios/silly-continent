class_name Plague extends Event

var default_data = {
	id = 4,
	name = "Plague",
	description = "Die or die dude"
}

const duration_min = 4
const duration_max = 6
const pop_min = 5000
const pop_loss_scale = -.05

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func can_activate(turn: int) -> bool:
	return (turn > 1 && randi_range(0, 5) == 0)

func activate():
	var target = get_target()
	if (target):
		target.get_pop_mod().set_const(get_name(), get_loss(target), random_duration())

func is_valid(territ: Territory) -> bool:
	return (territ.has_country() && territ.get_pop() >= pop_min)

func get_loss(territ: Territory) -> float:
	return territ.get_pop() * pop_loss_scale

func random_duration() -> int:
	return randi_range(duration_min, duration_max)
