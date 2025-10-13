class_name TerrainNode extends Node

const default_color = Color(0.157, 0.537, 0.22) #288938

@export_group("ui")
@export var shape: Polygon2D
@export var label: Label

var border: Line2D
var mouse_selected = false
var territory: Territory

func _ready():
	shape = get_child(0)
	label = shape.get_child(0)
	#add collision area
	var area = Area2D.new()
	var collisionShape = CollisionPolygon2D.new()
	add_child(area)
	area.add_child(collisionShape)
	area.input_event.connect(_on_input_event)
	if (collisionShape):
		collisionShape.polygon = shape.polygon
		collisionShape.position = shape.position
	
	border = Line2D.new()
	shape.add_child(border)
	border.closed = true
	border.width = 2.25
	border.default_color = Color.BLACK
	border.points = shape.polygon

func set_country_color(c):
	if (c):
		shape.color = c.get_color()
	else:
		shape.color = default_color

func _on_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if (Input.is_action_pressed('click-left')):
		SignalBus.open_terr_menu.emit(self)
	if (Input.is_action_pressed('click-right')):
		SignalBus.open_country_menu.emit(territory.get_country())

func _on_camera_label_switch():
	if (label.visible):
		label.visible = false
	else:
		label.visible = true