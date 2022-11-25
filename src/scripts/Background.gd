extends Node2D

export var bg_block_width : float

var bg_blocks_arr = [] # array of track_blocks present in a moment

func process_blocks(gamespeed, delta):
	# delete block's reference and node if it's 3000 pixels behind the screen
	if bg_blocks_arr[bg_blocks_arr.size() - 1].position.x < -3000:
		remove_child(bg_blocks_arr[bg_blocks_arr.size() - 1])
		bg_blocks_arr.pop_back()
		
	# if last block is closer than 2000 px to the front of the screen, generate new block
	if bg_blocks_arr[0].position.x < 2000:
		var new_x = bg_blocks_arr[0].position.x + bg_block_width
		bg_blocks_arr.push_front(generate_bg_block(new_x))
		add_child(bg_blocks_arr[0])
	
	# update position of all blocks by gamespeed
	for el in bg_blocks_arr:
		el.move_and_slide(Vector2((gamespeed * -1) / 10, 0))

# Setup of the generator
func _ready():	
	#generate first 6 blocks of track to kickstart the game
	for i in 6:
		var new_x = -bg_block_width * 2
		if i > 0:
			new_x = bg_blocks_arr[0].position.x + bg_block_width
		bg_blocks_arr.push_front(generate_bg_block(new_x))
		add_child(bg_blocks_arr[0])
		
func generate_bg_block(x):
	var bg_block = KinematicBody2D.new()
	var bg_sprite = Sprite.new()
	bg_sprite.texture = load("res://src/assets/bg-blocks/BACKGROUND.png")
	bg_sprite.centered = false
	bg_sprite.position = Vector2(0, 0)
	bg_block.add_child(bg_sprite)
	bg_block.position = Vector2(x, -128)
	
	return bg_block
