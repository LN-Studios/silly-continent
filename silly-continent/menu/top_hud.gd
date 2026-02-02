extends Container

@export var balance_label: Label
@export var turn_label: Label
@export var approval_label: Label
@export var rep_label: Label
@export var army_label: Label
@export var box: ColorRect

func _ready():
	SignalBus.game_start.connect(_start)
	SignalBus.turn_phase_z.connect(turn_phase_z)
	update_values(null)
	visible = true

func _start(country: Country):
	box.color = country.get_color()
	update_values(country)

func turn_phase_z(_turn):
	if (Main.game_is_started()):
		update_values(Main.get_user_country())

func update_values(country: Country):
	set_turn(Main.get_turn())
	if (country == null):
		set_balance(0, null)
		set_approval(0, null)
		set_reputation(0, null)
		set_army(0, null)
	else:
		set_balance(country.get_balance(), country.get_balance_mod())
		set_approval(country.get_approval(), country.get_approval_mod())
		set_reputation(country.get_reputation(), country.get_reputation_mod())
		set_army(country.get_army(), country.get_army_mod())

func set_turn(turn):
	turn_label.text = "Turn " + str(turn)

func set_balance(new, mod):
	balance_label.text = "$" + Main.format_float(new)
	if (mod):
		mod.set_tooltip(balance_label, true)

func set_approval(new, mod):
	approval_label.text = "Approval: %d%%" % int(new)
	if (mod):
		mod.set_tooltip(approval_label, false)

func set_reputation(new, mod):
	rep_label.text = "Reputation: " + str(new)
	if (mod):
		mod.set_tooltip(rep_label, false)

func set_army(new, mod):
	army_label.text = "Army size: " + str(new)
	if (mod):
		mod.set_tooltip(army_label, false)

func next_turn():
	if (Main.game_is_started()):
		Main.advance_turn()

func open_help():
	SignalBus.open_help.emit()
