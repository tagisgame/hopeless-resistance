extends Area2D

export var mash = 0

func _on_TriggerMash_body_entered(_body: KinematicBody2D):
	print("hitbox!")
	mash = 1
	
func _on_TriggerMash_body_exited(_body: KinematicBody2D):
	print("no")
	mash = 0
