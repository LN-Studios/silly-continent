extends Container

const main = preload("res://main/main.gd")

@export var balance_label: Label
@export var day_label: Label
@export var approval_label: Label
@export var rep_label: Label
@export var army_label: Label
@export var box: ColorRect

func _ready():
	SignalBus.turn_phase_a.connect(new_turn)
	SignalBus.new_balance.connect(_balance)
	SignalBus.new_approval.connect(_approval)
	SignalBus.new_reputation.connect(_reputation)
	SignalBus.new_army.connect(_army)
	SignalBus.game_start.connect(_start)
	_balance(0, null)
	_approval(0, null)
	_reputation(0, null)
	_army(0, null)
	visible = true

func _start(country):
	box.color = country.get_color()

func new_turn(turn):
	day_label.text = "Turn " + str(turn)

func _balance(new, mod):
	balance_label.text = "$" + main.format_float(new)
	if (mod):
		mod.set_tooltip(balance_label, true)

func _approval(new, mod):
	approval_label.text = "Approval: " + main.format_percent(new)
	if (mod):
		mod.set_tooltip(approval_label, false)

func _reputation(new, mod):
	rep_label.text = "Reputation: " + str(new)
	if (mod):
		mod.set_tooltip(rep_label, false)

func _army(new, mod):
	army_label.text = "Army size: " + str(new)
	if (mod):
		mod.set_tooltip(army_label, false)

func next_turn():
	SignalBus.next_turn.emit()

func open_help():
	SignalBus.open_help.emit()
