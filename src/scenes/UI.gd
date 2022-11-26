extends Control

onready var score_counter_node = get_node("ScoreCounter")

func _on_TriggerArea_body_entered(body, obstacle):
	if obstacle == "hurdle":
		get_node("PressUI").visible = true
		get_node("PressUI").get_node("ProgressBar").visible = false
	if obstacle == "door":
		get_node("MashUI").visible = true
		var progress_node = get_node("MashUI").get_node("ProgressBar")
		progress_node.value = 0
		
func _on_TriggerArea_body_exited(body, obstacle):
	get_node("PressUI").visible = false
	get_node("MashUI").visible = false

func _on_2dMain_scoreChanged(value):
	score_counter_node.text = str(value)


func _on_Player_broke():
	get_node("MashUI").visible = false


func _on_Player_jumped():
	get_node("PressUI").visible = false


func _on_Player_mash():
	var progress_node = get_node("MashUI").get_node("ProgressBar")
	progress_node.value += 1
