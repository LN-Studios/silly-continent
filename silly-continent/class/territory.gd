class_name Territory extends Node

const default_color = Color(0.157, 0.537, 0.22) #288938

@export_group("data")
@export var territ_name = ""
@export_range(0, 100000) var population = 100
@export var country: Country
@export var terrain: Terrain

@export_group("ui")
@export var shape: Polygon2D
@export var label: Label
var border: Line2D

var mouseSelected = false
var popChange: float
var taxMod: Modifier
var popMod: Modifier

const tax_pop_scale = .0003
const cost_dist_scale = .0001
const cost_pop_scale = .005
const pop_local_econ_scale = 0.1
const pop_natl_econ_scale = 0.15

var data = {
	name = territ_name,
	population = population,
	country = country,
	terrain = terrain,
}

func get_size():
	var size = ""
	if (population < 250): #0-249
		size = "Wilderness"
		popMod.set_mod(size, -0.2)
	elif(population < 1000): #250-999
		size = "Outskirts"
		popMod.set_mod(size, -0.1)
	elif(population < 10000): #1000-9999
		size = "Village"
		popMod.set_mod(size, 0.1)
	else: 
		size = "City" #10,000+
		popMod.set_mod(size, 0.2)
	return size.to_lower()

func _ready():
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
		
	#connect signals
	SignalBus.new_turn.connect(_turn)
	
	#set values
	set_country(country)
	territ_name = label.text.c_unescape()
	taxMod = Modifier.new()
	popMod = Modifier.new()
	terrain.set_effects(self)
	
func _turn(turn): 
	set_population()
	
func get_terrName(): return territ_name

func get_terrain(): return terrain.get_terrainName()

func get_country(): return country

# population modifiers
func get_popMod(): return popMod

func get_population(): return population

func get_popChange(): return popMod.compile()

func set_population():
	popMod.set_const("National economy", country.get_profit() * pop_natl_econ_scale)
	popMod.set_const("Local economy", get_profit() * pop_local_econ_scale)
	population += popMod.compile()
	if population < 0: population = 0

# tax modifiers
func get_taxMod(): return taxMod

func get_profit():
	set_tax()
	return taxMod.compile()
	
func set_tax():
	taxMod.set_const("Population", population * tax_pop_scale)
	taxMod.set_const("Distance to capital", -(get_capital_distance() * cost_dist_scale * (population * cost_pop_scale)))


func get_position(): return shape.position

func get_capital_distance():
	if (country.is_unclaimed()): return 0
	return get_position().distance_to(country.get_capital().get_position())
		
	
func set_country(c):
	if (c):
		shape.color = c.get_color()
		c.add_terr(self)
	else:
		shape.color = default_color
	country = c

func is_capital():
	if (country.is_unclaimed()): return false
	return country.get_capital() == self
	
func mod_purge(name: String):
	taxMod.erase(name)
	popMod.erase(name)
	
func _on_camera_label_switch():
	if (label.visible):
		label.visible = false
	else:
		label.visible = true

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (Input.is_action_pressed('click-left')):
		SignalBus.open_terr_menu.emit(self)
	if (Input.is_action_pressed('click-right')):
		SignalBus.open_country_menu.emit(country)
		
#events
func spawn_exodus(rate):
	popMod.set_const("Spawn Exodus", rate)

func end_spawn_exodus():
	popMod.get_consts().erase("Spawn Exodus")
