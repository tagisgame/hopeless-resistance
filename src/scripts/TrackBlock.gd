extends KinematicBody2D

signal HitboxArea_body_entered(body, block_obstacle)
signal HitboxArea_body_exited(body, block_obstacle)
signal TriggerArea_body_entered(body, block_obstacle)
signal TriggerArea_body_exited(body, block_obstacle)
signal ScoreArea_body_entered(body)

var block_data # Dictionary with all data for each block from JSON
var block_obstacle # var containing obstacle type
var width # chosen width of the block

# collision hitbox node reference
var hitbox_node

# QTE trigger node reference
var trigger_node

func _ready():
	pass 

# setup the block
func set_block_data(b_data):
	block_data = b_data
	block_obstacle = b_data.get("obstacle_type")
	
	# set texture for block
	var image_texture = ImageTexture.new()
	var image = Image.new()
	var image_path = "res://src/assets/track-blocks/img/" + b_data.get("ids")[randi() % b_data.get("ids").size()] + ".png"
	image.load(image_path)
	image_texture.create_from_image(image)
	
	get_node("Sprite").texture = image_texture
	
	# generation of hitboxes
	if block_obstacle != "none" and block_data.get("obstacle_hitboxes").has("hitbox"):
		var hitbox_data = block_data.get("obstacle_hitboxes").get("hitbox")
		var hitbox_shape = RectangleShape2D.new()
		var hitbox_pos1 = Vector2(hitbox_data.get("x1"), hitbox_data.get("y1"))
		var hitbox_pos2 = Vector2(hitbox_data.get("x2"), hitbox_data.get("y2"))
		var hitbox_size = Vector2(abs(hitbox_pos2.x - hitbox_pos1.x), abs(hitbox_pos2.y - hitbox_pos1.y))
		var hitbox_center = hitbox_pos1 + 0.5 * hitbox_size
		
		hitbox_shape.extents = hitbox_size * 0.5
		
		# ... and triggers if available
		var trigger_center = Vector2(0, 0)
		var trigger_shape = RectangleShape2D.new()
		if block_data.get("obstacle_hitboxes").has("trigger"):
			var trigger_data = block_data.get("obstacle_hitboxes").get("trigger")
			var trigger_pos1 = Vector2(trigger_data.get("x1"), trigger_data.get("y1"))
			var trigger_pos2 = Vector2(trigger_data.get("x2"), trigger_data.get("y2"))
			var trigger_size = Vector2(abs(trigger_pos2.x - trigger_pos1.x), abs(trigger_pos2.y - trigger_pos1.y))
			trigger_center = trigger_pos1 + 0.5 * trigger_size
			
			trigger_shape.extents = trigger_size * 0.5
			print(trigger_data)
			print("OBSTACLE: ", block_obstacle, " HITBOX: \npos_center:", hitbox_center, "\npos1: ", hitbox_pos1, "\npos2: ", hitbox_pos2, "\nextents: ", hitbox_shape.extents)
			print("OBSTACLE: ", block_obstacle, " TRIGGER: \npos_center:", trigger_center, "\npos1: ", trigger_pos1, "\npos2: ", trigger_pos1, "\nextents: ", trigger_shape.extents)
		
		
		
		# setting up correct collision boxes
		hitbox_node = get_node("HitboxArea/Hitbox")
		trigger_node = get_node("TriggerArea/Trigger")
		
		hitbox_node.shape = hitbox_shape
		hitbox_node.position = hitbox_center
		trigger_node.shape = trigger_shape
		trigger_node.position = trigger_center


func _on_HitboxArea_body_entered(body):
	emit_signal("HitboxArea_body_entered", body, block_obstacle)


func _on_HitboxArea_body_exited(body):
	emit_signal("HitboxArea_body_exited", body, block_obstacle)


func _on_TriggerArea_body_entered(body):
	emit_signal("TriggerArea_body_entered", body, block_obstacle)


func _on_TriggerArea_body_exited(body):
	emit_signal("TriggerArea_body_exited", body, block_obstacle)


func _on_ScoreArea_body_entered(body):
	emit_signal("ScoreArea_body_entered", body)
