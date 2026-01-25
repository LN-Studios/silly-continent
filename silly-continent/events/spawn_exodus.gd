class_name SpawnExodus extends Event

#gain: cunnington, slamong city, autobot city, squam
#minor loss: worl map, pudopia, cagliostro,  mudtown
#major loss: doofania
var territs = {
	"13" = 100,
	"25" = 100,
	"60" = 100,
	"72" = 100,
	"3" = -50,
	"4" = -50,
	"5" = -50,
	"6" = -50,
	"1" = -200
}

var default_data = {
	id = 1,
	name = "Spawn Exodus",
	description = "Overcrowding in the city of Doofania has caused many of its population to leave for other growing cities."
}

const start_turn = 2
const duration = 10

func _init(in_data = {}):
	data.merge(default_data, true)
	data.merge(in_data, true)
	super(data)

func can_activate(turn: int) -> bool:
	return (turn == start_turn)

func activate():
	for id in territs.keys():
		Lib.get_territ(int(id)).get_pop_mod().set_const(get_name(), territs[id], 10)
