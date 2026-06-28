extends CharacterBody2D

var speed = 100
var movement = RandomNumberGenerator.new()
var moving = false
var shootingArea = false
var target_x = 0.0
@onready var timer: Timer = $Timer
@onready var ani: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# Connect the timer signal if you didn't do it in the editor
	timer.timeout.connect(_on_timer_timeout)
	choose_target()

func choose_target():
	target_x = movement.randi_range(0, 574)
	moving = true
	print("New target picked: ", target_x)

func _physics_process(delta: float) -> void:
	# 1. Apply Gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	# 2. Handle Movement
	if moving and !shootingArea:
		var distance_to_target = target_x - global_position.x
		
		if abs(distance_to_target) < 5:
			ani.play("RESET")
			velocity.x = 0
			moving = false 
			print("Arrived! Waiting 1 second...")
			timer.start(1.0) # Start the wait timer ONCE when arriving
		else:
			var direction = sign(distance_to_target)
			velocity.x = direction * speed
			ani.play("walking")
		if distance_to_target <0:
			$body.flip_h  = true
			$arms.flip_h = true
			$arms.position.x = -12
			$Area2D/CollisionShape2D.position.x  = -67.75
		else :
			$body.flip_h  = false
			$arms.flip_h = false
			$arms.position.x = 12
			$Area2D/CollisionShape2D.position.x  = 67.75
	
	move_and_slide()

# 3. When the timer finishes waiting, pick a new target
func _on_timer_timeout() -> void:
	if !shootingArea:
		choose_target()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		shootingArea = true
		velocity.x = 0
		ani.play("RESET")
	move_and_slide()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("plr"):
		shootingArea = false
