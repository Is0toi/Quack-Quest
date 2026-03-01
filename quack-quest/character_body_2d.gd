@export var speed = 400
@onready var animations = $AnimatedSprite2D 

func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	update_animation(input_direction)
	move_and_slide()

func update_animation(dir):
	if dir == Vector2.ZERO:
		animations.play("idle")
	else:

		if abs(dir.x) > abs(dir.y):

			if dir.x > 0:
				animations.play("right_walk")
			else:
				animations.play("left_walk")
		else:
			# Vertical movement
			if dir.y > 0:
				animations.play("walk_down") # Front
			else:
				animations.play("walk_up")   # Back
