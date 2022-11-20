extends Node2D

# game setup variables
export var starting_gamespeed : float # gamespeed at the beginning of the game
export var gamespeed_increment : float # how faster should game gets each frame/block (tbd...)


var track_scene

func _ready():
	pass
	

func _on_Track_ready():
	track_scene = get_node("Track")
	track_scene.setup(starting_gamespeed, gamespeed_increment)
	
