extends PopupPanel


func _ready() -> void:
	SignalBus.game_start.connect(_start)
	
func _start(country):
	SignalBus.pause.connect(_pause)
	SignalBus.unpause.connect(_unpause)

func _pause():
	#visible = true
	pass
	
func _unpause():
	#visible = false
	pass

func _resume():
	#SignalBus.unpause.emit()
	pass
