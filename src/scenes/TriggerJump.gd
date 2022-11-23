extends Area2D

export var jump = 0

func _on_TriggerJump_body_entered(_body: KinematicBody2D):
	#print("hitbox!")
	jump = 1

func _on_TriggerJump_body_exited(_body: KinematicBody2D):
	#print("NO")
	jump = 0
