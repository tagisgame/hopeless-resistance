extends KinematicBody2D

#adds character var connected to in-game character
onready var character = get_node("Character") 
#adds character hitbox var
onready var hitbox = get_node("Hitbox") 

#vars :D
var jump_event = false
var crouch_event = true
var mash_event = false
var is_crouching = false
var is_jumping = false
var req_met = false
var mash_count = 0
export var mash_succes = 3

signal demise

#player enters trigger (here starts QTE)
func _on_TriggerArea_body_entered(body, trigger_type):
	
	is_crouching = false
	
	if trigger_type == "hurdle":
		jump_event = true
		crouch_event = false
		mash_event = false
	elif trigger_type == "door":
		jump_event = false
		crouch_event = false
		mash_event = true
		mash_count = 0
		
#player leaves trigger (only to allow him to crouch outside obstacles)
func _on_TriggerArea_body_exited(body, trigger_type):
	jump_event = false
	crouch_event = true
	mash_event = false

			
#player enters hitbox (kill area)
func _on_HitboxArea_body_entered(body, obstacle_type): 
	if req_met:
		if obstacle_type == "hurdle":
			jump_over()
		else:
			break_barricade()
	else:
		die()
		print("ded")
	
	req_met = false
	
	
	
func _physics_process(_delta):
	
	#crouch mechanic
	if Input.is_action_just_pressed("ui_accept") and crouch_event == true:
		is_crouching = true

	if Input.is_action_just_released("ui_accept") and crouch_event == true:
		is_crouching = false
		
	if is_crouching:
		hitbox.position.y = 638
	else: 
		hitbox.position.y = 538
					
					
	#jump mechanic
	if Input.is_action_just_pressed("ui_accept") and jump_event == true:
		req_met = true
		
	#mash mechanic
	if Input.is_action_just_pressed("ui_accept") and mash_event == true:
		if not mash_count >= mash_succes - 1:
			mash_count += 1
		else:
			print("kuba <3")
			req_met = true
	
	
#play jump anime
func jump_over():
	print("skoczek")
	pass
	
#play breaking bad anime
func break_barricade():
	print("broken :c")
	pass
	
#play deading anime
func die():
	print("dead ass")
	pass
