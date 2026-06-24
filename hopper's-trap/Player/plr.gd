extends CharacterBody2D
class_name Plr


var speed := 200.0
static var inLevel : float = false


func _physics_process(_delta: float) -> void:
	var direction
	if not inLevel:
		direction = Input.get_vector("Left","Right","Up","Down")
		if direction != Vector2.ZERO:
			velocity = direction * speed
		else:
			velocity = velocity.move_toward(Vector2.ZERO, speed)
	elif inLevel:
		direction = Input.get_axis("Left","Right")
		if direction != 0:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x,0, speed)
	move_and_slide()
