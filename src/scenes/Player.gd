extends KinematicBody2D


#Helps to change player hitbox in crouching state
onready var standing_collision = $StandingShape
onready var crouching_collision = $CrouchingShape
onready var standing_hitbox = $Hitbox/StandingShape
onready var crouching_hitbox = $Hitbox/CrouchingShape


func _on_crouch(): 
	
	standing_collision.disabled = true #disables standing collision
	crouching_collision.disabled = false #enables crouching collision
	standing_hitbox.disable = true #disables standing hitbox
	crouching_hitbox.disable = false #enables standing hitbox
	
func _on_stand(): #so it's the the opposite to the _on_crouch :O
	
	standing_collision.disabled = false #enables standing collision
	crouching_collision.disabled = true #disables crouching collision
	standing_hitbox.disable = false #enable standing hitbox
	crouching_hitbox.disable = true #disables standing hitbox
	
func _input(event):
	
	if(Input.action_press("ui_accept")):
		print("jump")
