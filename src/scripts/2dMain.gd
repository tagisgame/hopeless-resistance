extends Node2D

# game setup variables
export var starting_gamespeed : float # gamespeed at the beginning of the game
export var gamespeed_increment : float # how faster should game gets each frame/block (tbd...)
export var gamespeed_cap : float # maximum speed of the game

# score system
var score = 0
signal scoreChanged(value)

var gamespeed


var track_scene

func _ready():
	gamespeed = starting_gamespeed

func _process(delta):
	if track_scene:
		track_scene.process_blocks(gamespeed, delta)
		
	update_speed(delta)
	pass
	
	
func update_speed(delta):
	if gamespeed < gamespeed_cap:
		gamespeed += gamespeed_increment * delta

func _on_Track_ready():
	track_scene = get_node("Track")
	
func _on_ScoreArea_body_entered(body):
	score += 1
	emit_signal("scoreChanged", score)
