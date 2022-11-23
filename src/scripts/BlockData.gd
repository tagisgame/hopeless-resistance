extends Node

# This var holds all data for all track blocks
var track_blocks_data

func _ready():
	# Open a JSON file, get the data and close the file
	var track_blocks_data_file = File.new()
	track_blocks_data_file.open("res://src/assets/track-blocks/data/track-blocks.json", File.READ)
	track_blocks_data = JSON.parse(track_blocks_data_file.get_as_text()).result
	track_blocks_data = track_blocks_data.get("track_block_types")
	
	
	track_blocks_data_file.close()

func get_obstacle(obstacle, transition_to):
	var all_available = track_blocks_data.get(transition_to).values()
	
	for el in all_available:
		if el.get("obstacle_type") == obstacle:
			return el
