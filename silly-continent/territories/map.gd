extends "res://class/territory.gd"

func _ready() -> void:
	super()
	SignalBus.spawn_exodus.connect(spawn_exodus)
	SignalBus.end_spawn_exodus.connect(end_spawn_exodus)

func spawn_exodus(rate):
	super(rate)
	popMod.set_const("Spawn Exodus", rate * -0.5)
