extends VBoxContainer

@onready var parent_box = get_parent()
@onready var close = $close
@onready var name_label = $name
@onready var govt_label = $govt
@onready var balance_label = $balance
@onready var profit_label = $profit
@onready var pop_label = $pop
@onready var approval_label = $approval
@onready var rep_label = $rep
@onready var army_label = $army
@onready var select_button = $select
@onready var diplo_tree = $diplo


@export var color_box: ColorRect

var country: Country
var today: int
var gameStarted = false

func _ready():
	_on_close()
	SignalBus.open_country_menu.connect(_on_open)
	SignalBus.turn_phase_z.connect(_refresh)

func _process(_delta: float):
	if (parent_box.visible && Input.is_action_pressed('tab')):
		_on_close()
	
func _on_open(c: Country):
	if (c):
		country = c
		color_box.color = c.get_color()
		name_label.text = "\n" + c.get_name() + "\n"
		govt_label.text = "\n" + c.get_govt().get_name().capitalize()
		parent_box.set_visible(true)
		if (c.is_unclaimed()):
			balance_label.set_visible(false)
			profit_label.set_visible(false)
			pop_label.set_visible(false)
			approval_label.set_visible(false)
			rep_label.set_visible(false)
			army_label.set_visible(false)
			select_button.set_visible(false)
			diplo_tree.set_visible(false)
		else:
			_refresh(today)
			balance_label.set_visible(true)
			profit_label.set_visible(true)
			pop_label.set_visible(true)
			approval_label.set_visible(true)
			rep_label.set_visible(true)
			army_label.set_visible(true)
			select_button.set_visible(!gameStarted)
			fill_diplo_tree()
	else:
		_on_close()
	
func _on_close():
	parent_box.set_visible(false)

func _refresh(day):
	if (parent_box.visible):
		today = day
		balance_label.text = "\nBalance: $" + Main.format_float(country.get_balance())
		profit_label.text = "\nProfit: $" + Main.format_float(country.get_balance_mod().compile()) + "/turn"
		pop_label.text = "\nPopulation: %.f" % country.get_population()
		pop_label.tooltip_text = "Daily change: " + str(country.compile_pop_change())
		approval_label.text = "\nApproval rating: %d%" % country.get_approval()
		rep_label.text = "\nReputation: %.f" % country.get_reputation()
		army_label.text = "\nArmy size: %.f" % country.get_army()
		country.get_balance_mod().set_tooltip(profit_label, true)
		country.get_approval_mod().set_tooltip(approval_label, false)
		country.get_rep_mod().set_tooltip(rep_label, false)
		country.get_army_mod().set_tooltip(army_label, false)

func _on_country_selected():
	select_button.set_visible(false)
	country.set_CPU(false)
	gameStarted = true
	SignalBus.game_start.emit(country)
	
func fill_diplo_tree():
	diplo_tree.visible = true
	
