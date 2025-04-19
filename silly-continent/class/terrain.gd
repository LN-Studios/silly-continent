class_name Terrain extends Node

var terrainName: String

func _ready() -> void:
	pass
	
func get_terrainName():
	return terrainName

func set_terrainName(name):
	terrainName = name

func set_effects(t: Territory):
	pass
