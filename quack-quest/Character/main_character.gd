extends CharacterBody2D

@export var speed = 400
@onready var animations = $AnimatedSprite2D

var bread_count = 0
var udp := PacketPeerUDP.new()
var joy_dir := Vector2.ZERO
var end_count = 20

func _physics_process(delta):
	while udp.get_available_packet_count() > 0:
		var data = udp.get_packet().get_string_from_utf8()
		var parts = data.split(",")
		if parts.size() >= 2:
			var x = (float(parts[0]) - 512.0) / 512.0
			var y = (float(parts[1]) - 512.0) / 512.0
			joy_dir = Vector2(x, -y)

	var input_direction = joy_dir
	if input_direction == Vector2.ZERO:
		input_direction = Input.get_vector("left", "right", "up", "down")

	velocity = input_direction * speed
	update_animation(input_direction)
	move_and_slide()
	
func _ready():
	udp.bind(4242)

func update_animation(dir):
	if dir == Vector2.ZERO:
		animations.play("idle")
	else:
		if abs(dir.x) > abs(dir.y):
			animations.play("right")
			animations.flip_h = dir.x < 0
		else:
			if dir.y > 0:
				animations.play("front")
			else:
				animations.play("back")

func _on_area_2d_area_entered(area: Area2D) -> void:
	# 1. Check if it's actually bread
	if area.is_in_group("bread"):
		# 2. Update count using your setter
		set_bread(bread_count + 1)
		
		# 3. IMMEDIATELY remove the bread so it can't be hit again
		area.queue_free() 
		
		print("Bread collected! Total: ", bread_count)
		
		# 4. Check for win condition
		if bread_count >= end_count:
			get_tree().change_scene_to_file("res://Scenes/end.tscn")
	if area.is_in_group("bread"):
		# 2. Update count using your setter
		set_bread(bread_count + 1)
		
		# 3. IMMEDIATELY remove the bread so it can't be hit again
		area.queue_free() 
		
		print("Bread collected! Total: ", bread_count)

# 4. Check for win condition
		if bread_count >= end_count:
			get_tree().change_scene_to_file("res://Scenes/end.tscn")
	
	
func set_bread(new_bread: int) -> void:
	bread_count = new_bread
	
