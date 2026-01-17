extends Node

@export var camera: Camera2D

var help_menu = preload("res://menu/help.gd")

var tick: = 0
var day = 1
var year = 1
var turn = 0
var game_started = false

func _ready() -> void:
	SignalBus.game_start.connect(_start)
	#Lib.add_defaults()
	save_state()
	load_state()
	
func _start(country):
	game_started = true
	SignalBus.pause.emit()
	SignalBus.new_turn.emit(day)
	SignalBus.new_year.emit(year)

func save_state():
	Lib.save_state()

func load_state():
	Lib.load_state()
	SignalBus.finish_loading.emit()
	
func get_camera():
	return camera
	
static func format_float(amt: float):
	var av_amt = abs(amt)
	if (av_amt < 1000.0): #0 to 1,000
		return "%.2f" % amt
	elif (av_amt < 10000.0): #1,000 to 10,000
		return "%.f" % amt
	elif (av_amt < 1000000.0): #10,000 to 1m
		return "%.1fk" % (amt / 1000)
	elif (av_amt < 1000000000.0): #1m to 1b
		return "%.1fm" % (amt / 1000000)
	elif (av_amt < 1000000000000.0): #1b to 1t
		return "%.1fb" % (amt / 1000000000)
	elif (amt < -1000000000000.0): #<-1t
		return "just restart at this point"
	else: #>1t
		return "way too much"

static func format_percent(amt: float):
	var pct = amt * 100
	if (round(pct) == 0):
		return "0%"
	var av_pct = abs(pct)
	if (amt == 0.00):
		return "%.f" % amt
	if (av_pct >= 10.0):
		return "%.f%%" % pct
	elif (av_pct >= 1.0):
		return "%.1f%%" % pct
	else:
		return "%.2f%%" % pct
	
