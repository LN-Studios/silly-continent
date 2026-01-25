extends Node

func _ready():
	SignalBus.all_nodes_loaded.emit()
