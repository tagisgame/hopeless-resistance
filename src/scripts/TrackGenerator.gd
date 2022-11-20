extends Node

var track_block_scene = preload("res://src/scenes/TrackBlock.tscn")

# Global variables for the track generation
var gamespeed #
var gamespeed_increment # how faster should game gets each frame/block (tbd...)
export var obstacles_frequency : int # how many tiles between the obstacles
export var max_halfwalls_in_a_row : int # max number of shorter wall in a row 
export var max_hurdles_in_a_row : int # max number of obstacles that require jumping in a row
export var max_barricades_in_a_row : int # max number of barricades that require mashing in a row
export var track_block_width : int # width of track block in pixels

# Code trackers
var next_obstacle # how many block until new obstacle
var halfwalls_in_a_row = 0 # how many halfwalls in a row
var hurdles_in_a_row = 0 # how many obstacles that require jumping in a row
var barricades_in_a_row = 0 # how many barricades that require mashing in a row
var indoor = false # are blocks indoor at the moment
var last_block_data # data of last block

var track_block_data # data of all track block

var track_blocks_arr = []

		
func _process(delta):
	print(gamespeed)
	if track_blocks_arr[track_blocks_arr.size() - 1].position.x < -1280:
		print("track block removing...")
		track_blocks_arr.pop_back()
		
		var new_x = track_blocks_arr[0].position.x + 427
		track_blocks_arr.push_front(generate_track_block(new_x))
		add_child(track_blocks_arr[0])
		
	for el in track_blocks_arr:
		el.move_and_slide(Vector2((gamespeed * -1), 0))
		update_speed(delta)

# Setup of the generator
func setup(st_gamespeed, gamespeed_inc):
	gamespeed = st_gamespeed
	gamespeed_increment = gamespeed_inc
	
	next_obstacle = obstacles_frequency
	track_block_data = BlockData.track_blocks_data
	last_block_data = track_block_data[0]
	
	for i in 6:
		var new_x = 0
		if i > 0:
			new_x = track_blocks_arr[0].position.x + track_block_width
		track_blocks_arr.push_front(generate_track_block(new_x))
		add_child(track_blocks_arr[0])
	
# Function generating track block
func generate_track_block(x = 0):
	print("track block generating...")
	var next_block_data
	var next_block = track_block_scene.instance()
	
	if next_obstacle > 0:
		next_block_data = track_block_data[0]
		next_obstacle -= 1
	else:
		next_block_data = track_block_data[1]
		next_obstacle = obstacles_frequency
	
	randomize()
	var next_block_texture_path = "res://src/assets/track-blocks/img/" + next_block_data.ids[randi() % next_block_data.ids.size()] + ".png"
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load(next_block_texture_path)
	texture.create_from_image(image)
	next_block.get_node("Sprite").texture = texture
	next_block.position = Vector2(x, 0)
	
	#update_speed()
	
	return next_block
	
func update_speed(delta):
	print("updating speed with increment of:" + str(gamespeed_increment))
	print("old speed:" + str(gamespeed))
	gamespeed += gamespeed_increment * delta
	print("new speed:" + str(gamespeed))
