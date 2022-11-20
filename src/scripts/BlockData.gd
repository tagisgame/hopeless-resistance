extends Node

# This var holds all data for all track blocks
var track_blocks_data

func _ready():
	# Open a JSON file, get the data and close the file
	var track_blocks_data_file = File.new()
	track_blocks_data_file.open("res://src/assets/track-blocks/data/track-blocks.json", File.READ)
	track_blocks_data = JSON.parse(track_blocks_data_file.get_as_text()).result
	track_blocks_data = track_blocks_data.get("track_blocks_types")
	
	track_blocks_data_file.close()
