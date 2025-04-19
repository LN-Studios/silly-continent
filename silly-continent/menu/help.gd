extends ColorRect

func _ready():
	SignalBus.open_help.connect(switch_visibility)
	visible = true
	
func _process(_delta: float) -> void:
	#pause check
	if (Input.is_action_just_pressed('escape')):
		switch_visibility()
		
func switch_visibility():
	visible = !visible

func _on_show():
	visible = true

func _on_hide():
	visible = false
