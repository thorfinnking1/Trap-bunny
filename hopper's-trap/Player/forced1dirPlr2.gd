extends CharacterBody2D

var speed = 200.0
var direction
var jump_velocity = -400

@onready var ani: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("Left","Right")
	if !is_on_floor():
		velocity.y += get_gravity().y *delta
	if is_on_floor():
		if Input.is_action_just_pressed("Jump"):
			velocity.y = jump_velocity
	if direction != 0:
		ani.play("running")
		velocity.x = direction * speed
		if direction<=0:
			$Rabbit.flip_h = true
			$Rabbit/ears.flip_h = true
			$Rabbit/ears.position = Vector2(-8.0,-21.0)
		else:
			$Rabbit/ears.position = Vector2(8.0,-21.0)
			$Rabbit.flip_h = false
			$Rabbit/ears.flip_h = false
	else:
		velocity.x = move_toward(velocity.x,0, speed)
	move_and_slide()
