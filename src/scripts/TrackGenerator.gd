extends Node

var track_block_scene = preload("res://src/scenes/TrackBlock.tscn")

# WARNING: NEVER PUT THOSE AT ZERO -> INFINITE LOOP
export var obstacles_frequency : int # how many tiles between the obstacles
export var max_halfwalls_in_a_row : int # max number of shorter wall in a row 
export var max_hurdles_in_a_row : int # max number of obstacles that require jumping in a row
export var max_barricades_in_a_row : int # max number of barricades that require mashing in a row
export var track_block_width : int # width of track block in pixels
var obstacles_arr = ["hole", "hurdle", "door"] # available obstacles

# Code trackers
var next_obstacle # how many block until new obstacle
var halfwalls_in_a_row = 0 # how many halfwalls in a row
var hurdles_in_a_row = 0 # how many obstacles that require jumping in a row
var barricades_in_a_row = 0 # how many barricades that require mashing in a row
var indoor = false # are blocks indoor at the moment
var last_block_data # data of last block

var track_block_data # data of all track block

var track_blocks_arr = [] # array of track_blocks present in a moment

func process_blocks(gamespeed, delta):
	# delete block's reference and node if it's 3000 pixels behind the screen
	if track_blocks_arr[track_blocks_arr.size() - 1].position.x < -3000:
		remove_child(track_blocks_arr[track_blocks_arr.size() - 1])
		track_blocks_arr.pop_back()
		
	# if last block is closer than 2000 px to the front of the screen, generate new block
	if track_blocks_arr[0].position.x < 2000:
		var last_block_data = track_blocks_arr[0].block_data
		var new_x = track_blocks_arr[0].position.x + track_block_width
		track_blocks_arr.push_front(generate_track_block(last_block_data, new_x))
		add_child(track_blocks_arr[0])
	
	# update position of all blocks by gamespeed
	for el in track_blocks_arr:
		el.move_and_slide(Vector2((gamespeed * -1), 0))

# Setup of the generator
func _ready():
	# get initial values
	next_obstacle = obstacles_frequency
	track_block_data = BlockData.track_blocks_data
	last_block_data = BlockData.get_obstacle("none", "outdoor")
	
	#generate first 6 blocks of track to kickstart the game
	for i in 6:
		var new_x = -track_block_width * 2
		if i > 0:
			last_block_data = track_blocks_arr[0].block_data
			new_x = track_blocks_arr[0].position.x + track_block_width
		track_blocks_arr.push_front(generate_track_block(last_block_data, new_x))
		add_child(track_blocks_arr[0])
	
# Function generating track block
func generate_track_block(last_block_data, x = 0):
	# create vars for next block data and next block instance itself
	var next_block_data
	var next_block = track_block_scene.instance()
	
	# get transition to of last block
	var transition_to = last_block_data.get("transition_to")
	
	# if there is still a clear block needed before a obstacle, get block data with none
	if next_obstacle > 0:
		next_block_data = BlockData.get_obstacle("none", transition_to)
		next_obstacle -= 1
	# if there is a need of obstacle choose random one from available and
	# get block data with chosen obstacle type
	else:
		var obstacle_found = false # will be true, if conditions of obstacles in a row are met and valid obstacle is found
		var obstacle # var for obstacle type
		
		# loops until valid obstacle is found
		while not obstacle_found:
			randomize()
			obstacle = obstacles_arr[randi() % obstacles_arr.size()]
			if obstacle == "hole" and halfwalls_in_a_row < max_halfwalls_in_a_row:
				halfwalls_in_a_row += 1
				hurdles_in_a_row = 0
				barricades_in_a_row = 0
				obstacle_found = true
			elif obstacle == "hurdle" and hurdles_in_a_row < max_hurdles_in_a_row:
				halfwalls_in_a_row = 0
				hurdles_in_a_row += 1
				barricades_in_a_row = 0
				obstacle_found = true
			elif obstacle == "door" and barricades_in_a_row < max_barricades_in_a_row:
				halfwalls_in_a_row = 0
				hurdles_in_a_row = 0
				barricades_in_a_row += 1
				obstacle_found = true
			
		next_block_data = BlockData.get_obstacle(obstacle, transition_to)
		next_obstacle = obstacles_frequency
	
	"""print("GENERATING BLOCK: ", next_block_data, " on x: " + str(x))
	print("LAST BLOCK DATA: ", last_block_data)
	print("\n")"""
	next_block.set_block_data(next_block_data)
	next_block.position.x = x - 1
	
	next_block.connect("ScoreArea_body_entered", get_parent(), "_on_ScoreArea_body_entered")
	
	return next_block
