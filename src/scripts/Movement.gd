extends KinematicBody2D

onready var character = get_node("Character") #adds character var connected to in-game character
onready var hitbox = get_node("StandingShape") #adds character hitbox var
onready var areahitbox = get_node("TriggerAreaTest/TriggerAreaHitboxTest") 

var object = character

func _physics_process(delta):
	
	if character.has_method("interact"):
		print("collision")
	
	if Input.is_action_just_pressed("ui_accept"): #checks if spacebar has been PRESSED
		character.position.y += 100 #changes player y position to crouch state -temp
		hitbox.position.y += 100 #changes players hitbox y position to match player y position -temp
		print("crouch") #just to make sure lol
		
	if Input.is_action_just_released("ui_accept"): #checks if spacebar has been RELEASED
		character.position.y -= 100 #resets player y position to stanging state - temp
		hitbox.position.y -= 100 #changes player hitbox y position to match player y position =temp
		print("nice") # again - just to make sure
		
		
		
#It ain't perfect and it ain't much, better than my first verion where I used global.position (wtf)
#Please don't scream It's 2AM I just wanna sleep
#At least now I know how to make dis, well do I?
