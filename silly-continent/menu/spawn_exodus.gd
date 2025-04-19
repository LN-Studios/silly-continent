extends ColorRect

func _ready():
	SignalBus.spawn_exodus.connect(_on_show)
	visible = false
	
func _process(_delta: float) -> void:
	if (visible && Input.is_action_just_pressed('escape')):
		_on_hide()

func _on_show(rate):
	SignalBus.pause.emit()
	visible = true

func _on_hide():
	SignalBus.unpause.emit()
	visible = false
