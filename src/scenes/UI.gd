extends Control

onready var score_counter_node = get_node("ScoreCounter")

func _on_2dMain_scoreChanged(value):
	score_counter_node.text = str(value)
