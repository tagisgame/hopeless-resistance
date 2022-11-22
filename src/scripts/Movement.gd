extends KinematicBody2D

onready var character = get_node("Character") #adds character var connected to in-game character
onready var hitbox = get_node("StandingShape") #adds character hitbox var

onready var jump = get_node("../TriggerJump")
onready var crouch = get_node("../TriggerCrouch")
onready var mash = get_node("../TriggerMash")

var doormash = 0

func _physics_process(_delta):
	
	if Input.is_action_just_pressed("ui_accept") and jump.jump == 1: #checks 2 conditions: pressed spacebar and if var jump in TriggerJump is = 1 
		character.position.y -= 100 #if yes jump lmao
		hitbox.position.y -= 100
	
	if Input.is_action_just_released("ui_accept") and jump.jump == 1: #
		character.position.y += 100
		hitbox.position.y += 100
		
	if Input.is_action_just_pressed("ui_accept") and crouch.crouch == 1: #checks 2 conditions: pressed spacebar and if var crouch in TriggerJump is = 1 
		character.position.y += 100 #if yes jump lmao
		hitbox.position.y += 100
	
	if Input.is_action_just_released("ui_accept") and crouch.crouch == 1: #
		character.position.y -= 100
		hitbox.position.y -= 100
		
		
	if Input.is_action_just_pressed("ui_accept") and mash.mash == 1:
		if doormash >= 100:
			character.position.x += 150
			hitbox.position.x += 150
		else:
			doormash = doormash + rand_range(5, 10) 
			print(doormash)
			
	if Input.is_action_just_released("ui_accept") and mash.mash == 0:
		doormash = 0
















		
	if Input.is_action_just_pressed("ui_left"): #temp - just to check in hitbox area
		character.position.x = 270
		hitbox.position.x = 350
		
	if Input.is_action_just_pressed("ui_up"): #temp - just to check in hitbox area
		character.position.x = 420
		hitbox.position.x = 500
		
	if Input.is_action_just_pressed("ui_right"): #temp - just to check in hitbox area
		character.position.x = 570
		hitbox.position.x = 650
		
	if Input.is_action_just_pressed("ui_down"): #temp - just to check in hitbox area
		character.position.x = 120
		hitbox.position.x = 200
		
#It ain't perfect and it ain't much, better than my first verion where I used global.position (wtf)
#Please don't scream It's 2AM I just wanna sleep
#At least now I know how to make this



