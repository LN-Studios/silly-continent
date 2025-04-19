extends Camera2D

const panSpeed = 12
const zoomSpeed = 0.05
const labelThreshold = 0.9
const min_zoom = 0.3
const max_zoom = 1.5

var outerLabels = false

signal switchLabels()

# Called when the node enters the scene tree
func _ready() -> void:
	make_current()

# Called every frame
func _process(delta: float) -> void:
	getPanInput()
	getZoomInput()

func getPanInput():
	if Input.is_action_pressed('left') && offset.x > limit_left:
		pan(Vector2.LEFT)
	if Input.is_action_pressed('right') && offset.x < limit_right:
		pan(Vector2.RIGHT)
	if Input.is_action_pressed('up') && offset.y > limit_top:
		pan(Vector2.UP)
	if Input.is_action_pressed('down') && offset.y < limit_bottom:
		pan(Vector2.DOWN)
		
func pan(direction: Vector2):
	offset += direction * panSpeed

func getZoomInput():
	if Input.is_action_just_released('zoom-out') && zoom.x > min_zoom:
		doZoom(false)
	if Input.is_action_just_released('zoom-in') && zoom.x < max_zoom:
		doZoom(true)
	if (!outerLabels && zoom.x < labelThreshold):
		outerLabels = true
		switchLabels.emit()
	elif (outerLabels && zoom.x > labelThreshold):
		outerLabels = false
		switchLabels.emit()

func doZoom(zoomIn: bool):
	var newZoom = zoom.x
	if (zoomIn):
		newZoom += zoomSpeed
	else:
		newZoom -= zoomSpeed
	zoom = Vector2(newZoom, newZoom)
