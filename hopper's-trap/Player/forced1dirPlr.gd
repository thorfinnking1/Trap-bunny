extends CharacterBody2D

const SPEED = 200.0

func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("Up", "Down")
	if direction:
		if direction==1 and global_position.y<320:
			velocity.y = direction * SPEED
		elif direction==-1 and global_position.y>240:
			velocity.y = direction * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
