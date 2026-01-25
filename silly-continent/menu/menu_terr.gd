extends VBoxContainer

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
	SignalBus.turn_phase_z.connect(_refresh)

func _process(_delta: float) -> void:
	if (box.visible && Input.is_action_pressed('tab')):
		_on_close()
	
func _on_open(ty: Territory):
	if (ty):
		box.set_color(ty.get_country().get_color())
		nameLabel.text = "\n" + ty.get_name()
		if (ty.is_capital()):
			nameLabel.text += "\nCapital of " + ty.get_country().get_name()
		terrainLabel.text = "\n" + ty.get_terrain_name().capitalize() + " " + ty.get_size()
		territory = ty
		box.set_visible(true)
		_refresh(today)
	else:
		print("no territory provided")
		_on_close()

func _refresh(day):
	if (box.visible):
		today = day
		populationLabel.text = "\nPopulation: %.f\n" % territory.get_population()
		taxLabel.text = "\nRevenue: $" + Main.format_float(territory.get_profit()) + "/day\n"
		territory.get_profit_mod().set_tooltip(taxLabel, true)
		populationLabel.tooltip_text = "Daily change: " + str(territory.get_pop_change()) + "\n" + territory.get_pop_mod().get_list(false)

func _on_close():
	box.set_visible(false)
