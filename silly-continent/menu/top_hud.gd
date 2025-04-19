extends HBoxContainer

const main = preload("res://main/main.gd")

@export var balanceLabel: Label
@export var dayLabel: Label
@export var yearLabel: Label
@export var approvalLabel: Label
@export var repLabel: Label
@export var armyLabel: Label
@export var pausedLabel: Label
@export var box: ColorRect

func _ready():
	SignalBus.new_day.connect(_day)
	SignalBus.new_year.connect(_year)
	SignalBus.new_balance.connect(_balance)
	SignalBus.new_approval.connect(_approval)
	SignalBus.new_reputation.connect(_reputation)
	SignalBus.new_army.connect(_army)
	SignalBus.game_start.connect(_start)
	_balance(0, null)
	_approval(0, null)
	_reputation(0, null)
	_army(0, null)
	_unpause()

func _start(country):
	box.color = country.get_color()
	SignalBus.pause.connect(_pause)
	SignalBus.unpause.connect(_unpause)

func _day(day):
	dayLabel.text = "Day " + str(day)
	
func _year(year):
		yearLabel.text = "Year " + str(year)

func _pause():
	pausedLabel.text = "%6s" % "Paused"
	
func _unpause():
	pausedLabel.text = "%6s" % ""

func _balance(new, mod):
	balanceLabel.text = "$" + main.format_float(new)
	if (mod):
		mod.set_tooltip(balanceLabel, true)

func _approval(new, mod):
	approvalLabel.text = "Approval: " + main.format_percent(new)
	if (mod):
		mod.set_tooltip(approvalLabel, false)

func _reputation(new, mod):
	repLabel.text = "Reputation: " + str(new)
	if (mod):
		mod.set_tooltip(repLabel, false)

func _army(new, mod):
	armyLabel.text = "Army size: " + str(new)
	if (mod):
		mod.set_tooltip(armyLabel, false)

func open_help():
	SignalBus.open_help.emit()
