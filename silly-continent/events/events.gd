class_name Events extends Node

func _ready():
	SignalBus.game_start.connect(_start)
	SignalBus.new_year.connect(_year)
	
func _start(country):
	SignalBus.spawn_exodus.emit(0.5)

func _year(year):
	if year >= 5:
		SignalBus.end_spawn_exodus.emit()
