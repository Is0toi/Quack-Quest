extends CharacterBody2D

@export var speed = 400
@onready var animations = $AnimatedSprite2D

var bread_count = 0

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
			animations.play("right")
			animations.flip_h = dir.x < 0
		else:
			if dir.y > 0:
				animations.play("front")
			else:
				animations.play("back")


func set_bread(new_bread: int) -> void:
	bread_count = new_bread


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bread"):
		set_bread(bread_count+1)
		print(bread_count)
