extends KinematicBody2D

var block_data # Dictionary with all data for each block from JSON
var width # chosen width of the block

func _ready():
	pass 

# setup the block
func set_block_data(b_data):
	block_data = b_data
	var image_texture = ImageTexture.new()
	var image = Image.new()
	var image_path = "res://src/assets/track-blocks/img/" + b_data.get("ids")[randi() % b_data.get("ids").size()] + ".png"
	image.load(image_path)
	image_texture.create_from_image(image)
	
	get_node("Sprite").texture = image_texture
	
	width = b_data.get("width")[randi() % b_data.get("width").size()]
	get_node("Sprite").region_rect.size = Vector2(width, 592)
	
	if block_data.get("obstacle_type") != "none":
		var hitbox_shape = RectangleShape2D.new()
		var hitbox_data = block_data.get("obstacle_hitboxes").get("hitbox")
		var hitbox_pos1 = Vector2(hitbox_data.get("x1"), hitbox_data.get("y1"))
		var hitbox_pos2 = Vector2(hitbox_data.get("x2"), hitbox_data.get("y2"))
		var hitbox_size = hitbox_pos1 - hitbox_pos2
		var hitbox_pos_center = hitbox_pos1 + 0.5 * hitbox_size
		var hitbox_extents = hitbox_size * 0.5
		
		hitbox_shape.extents = hitbox_extents
		
		var hitbox_node = get_node("Obstacle_hitbox")
		hitbox_node.position = hitbox_pos_center
		hitbox_node.shape = hitbox_shape

