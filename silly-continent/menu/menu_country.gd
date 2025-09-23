extends VBoxContainer

const main = preload("res://main/main.gd")

@onready var box = get_parent()
@onready var close = $close
@onready var nameLabel = $name
@onready var govtLabel = $govt
@onready var balanceLabel = $balance
@onready var profitLabel = $profit
@onready var popLabel = $pop
@onready var approvalLabel = $approval
@onready var repLabel = $rep
@onready var armyLabel = $army
@onready var selectButton = $select
@onready var diploTree = $diplo

var country: Country
var today: int
var gameStarted = false

func _ready():
	_on_close()
	SignalBus.open_country_menu.connect(_on_open)
	SignalBus.new_turn.connect(_refresh)

func _process(_delta: float):
	if (box.visible && Input.is_action_pressed('tab')):
		_on_close()
	
func _on_open(c: Country):
	if (c):
		country = c
		box.color = c.get_color()
		nameLabel.text = "\n" + c.get_countryName() + "\n"
		govtLabel.text = "\n" + c.get_govtType().get_gtName().capitalize()
		box.set_visible(true)
		if (c.is_unclaimed()):
			balanceLabel.set_visible(false)
			profitLabel.set_visible(false)
			popLabel.set_visible(false)
			approvalLabel.set_visible(false)
			repLabel.set_visible(false)
			armyLabel.set_visible(false)
			selectButton.set_visible(false)
			diploTree.set_visible(false)
		else:
			_refresh(today)
			balanceLabel.set_visible(true)
			profitLabel.set_visible(true)
			popLabel.set_visible(true)
			approvalLabel.set_visible(true)
			repLabel.set_visible(true)
			armyLabel.set_visible(true)
			selectButton.set_visible(!gameStarted)
			fillDiploTree()
	else:
		_on_close()
	
func _on_close():
	box.set_visible(false)

func _refresh(day):
	if (box.visible):
		today = day
		balanceLabel.text = "\nBalance: $" + main.format_float(country.get_balance())
		profitLabel.text = "\nProfit: $" + main.format_float(country.get_profit()) + "/day"
		popLabel.text = "\nPopulation: %.f" % country.get_population()
		popLabel.tooltip_text = "Daily change: " + main.format_float(country.compile_popChange())
		approvalLabel.text = "\nApproval rating: " + main.format_percent(country.get_approval())
		repLabel.text = "\nReputation: %.f" % country.get_reputation()
		armyLabel.text = "\nArmy size: %.f" % country.get_army()
		country.get_profitMod().set_tooltip(profitLabel, true)
		country.get_approvalMod().set_tooltip(approvalLabel, false)
		country.get_repMod().set_tooltip(repLabel, false)
		country.get_armyMod().set_tooltip(armyLabel, false)

func _on_country_selected():
	selectButton.set_visible(false)
	country.set_CPU(false)
	gameStarted = true
	SignalBus.game_start.emit(country)
	
func fillDiploTree():
	diploTree.visible = true
	
