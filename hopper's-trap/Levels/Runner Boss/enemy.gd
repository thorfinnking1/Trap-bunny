extends CharacterBody2D

var speed = 200
var movement = RandomNumberGenerator.new()
var moving = false
var target_x = 0.0


func choose():
	target_x = movement.randi_range(0, 574)
	moving = true
	print("New target picked: ", target_x)
	
func move():

	var distance_to_target = target_x - global_position.x
	# Check if we are close enough to stop (within 5 pixels)
	if abs(distance_to_target) < 5:
		velocity.x = 0
		moving = false # This will trigger a new target on the next frame!
		print("Arrived!")
	else:
		# sign() returns -1 if negative, 1 if positive, 0 if zero
		var direction = sign(distance_to_target)
		velocity.x = direction * speed

func _physics_process(delta: float) -> void:
	# 1. Apply Gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# 2. Pick a new random target if not currently moving
	if not moving:
		choose()
	# 3. Move toward the target if we are moving
	elif moving:
		move()

	# 4. Execute movement
	move_and_slide()
