extends Area2D

export var crouch = 0

func _on_TriggerCrouch_body_entered(_body: KinematicBody2D):
	#print("HItbox")
	crouch = 1
	
func _on_TriggerCrouch_body_exited(_body: KinematicBody2D):
	#print("NO")
	crouch = 0
