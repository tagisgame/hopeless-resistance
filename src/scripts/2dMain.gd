extends Node2D

# game setup variables
export var starting_gamespeed : float # gamespeed at the beginning of the game
export var gamespeed_increment : float # how faster should game gets each frame/block (tbd...)
export var gamespeed_cap : float # maximum speed of the game

# score system
var score = 0
signal scoreChanged(value)

var gamespeed



onready var track_scene = get_node("Track")
onready var bg_scene = get_node("Background")
onready var obs_frequency = track_scene.obstacles_frequency

func _ready():
	gamespeed = starting_gamespeed

func _process(delta):
	track_scene.process_blocks(gamespeed, delta)
	bg_scene.process_blocks(gamespeed, delta)
		
	update_speed(delta)
	
	if obs_frequency >= 2:
		obs_frequency -= 0.03 * delta
	track_scene.obstacles_frequency = ceil(obs_frequency)
	pass
	
	
func update_speed(delta):
	if gamespeed < gamespeed_cap:
		gamespeed += gamespeed_increment * delta

func _on_ScoreArea_body_entered(body):
	score += 1
	emit_signal("scoreChanged", score)


func _on_Player_Character_Died():
	get_tree().reload_current_scene()
	get_tree().change_scene("res://src/scenes/GameOverScreen.tscn")
