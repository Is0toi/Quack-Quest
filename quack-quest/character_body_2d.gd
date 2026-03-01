extends CharacterBody2D  # This fixes the 'velocity' and 'move_and_slide' errors

@export var speed = 400

@onready var animations = $AnimatedSprite2D 

func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")

	velocity = input_direction * speed
	move_and_slide()

	update_animation(input_direction)

func update_animation(dir):
	if dir == Vector2.ZERO:
		animations.play("idle")
	else:
		if abs(dir.x) > abs(dir.y):
			animations.play("walk_right")
			animations.flip_h = dir.x < 0
		else:
			if dir.y > 0:
				animations.play("walk_down")
			else:
				animations.play("walk_up")
