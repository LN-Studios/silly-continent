extends VBoxContainer

const main = preload("res://main/main.gd")

@export var close: Button
@export var nameLabel: Label
@export var terrainLabel: Label
@export var populationLabel: Label
@export var taxLabel: Label
@export var box: ColorRect

var territory: Territory
var today: int

func _ready() -> void:
	_on_close()
	SignalBus.open_terr_menu.connect(_on_open)
	SignalBus.new_day.connect(_refresh)

func _process(_delta: float) -> void:
	if (box.visible && Input.is_action_pressed('tab')):
		_on_close()
	
func _on_open(t: Territory):
	if (t):
		box.set_color(t.get_country().get_color())
		nameLabel.text = "\n" + t.get_terrName()
		if (t.is_capital()):
			nameLabel.text += "\nCapital of " + t.get_country().get_countryName()
		terrainLabel.text = "\n" + t.get_terrain() + " " + t.get_size()
		territory = t
		box.set_visible(true)
		_refresh(today)
	else:
		print("no territory provided")
		_on_close()

func _refresh(day):
	if (box.visible):
		today = day
		populationLabel.text = "\nPopulation: %.f\n" % territory.get_population()
		taxLabel.text = "\nRevenue: $" + main.format_float(territory.get_profit()) + "/day\n"
		territory.get_taxMod().set_tooltip(taxLabel, true)
		populationLabel.tooltip_text = "Daily change: " + main.format_float(territory.get_popChange())  + "\n" + territory.get_popMod().get_list(false)

func _on_close():
	box.set_visible(false)
