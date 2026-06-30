extends CharacterBody2D

var speed = 100
var movement = RandomNumberGenerator.new()
var moving = false
var shootingArea = false
var target_x = 0.0
var is_reloading = false
var is_shooting = false  # Added to prevent gun-spamming

@export var bullets : int = 2
@export var plr : CharacterBody2D

@onready var timershoot: Timer = $timershoot
@onready var timer: Timer = $Timer
@onready var ani: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	choose_target()

func choose_target():
	target_x = movement.randi_range(76, 490)
	moving = true

func _physics_process(_delta: float) -> void:
	# 1. Handle Shooting & Reloading Logic First
	if shootingArea and not is_reloading and not is_shooting:
		velocity.x = 0 # Freeze movement while trying to action
		if bullets > 0:
			shoot()
		else:
			reload()
	
	# 2. Handle Movement (Only if NOT shooting or reloading)
	elif moving and not shootingArea and not is_reloading:
		var distance_to_target = target_x - global_position.x
		
		if abs(distance_to_target) < 5:
			velocity.x = 0
			moving = false 
			timer.start(1.0) 
		else:
			var direction = sign(distance_to_target)
			velocity.x = direction * speed
			if not ani.is_playing():
				ani.play("walking")
				
		# Flip sprites based on direction
		if distance_to_target < 0:
			$body.flip_h  = true
			$arms.flip_h = true
			$arms.position.x = -12
			$Area2D/CollisionShape2D.position.x  = -67
		else:
			$body.flip_h  = false
			$arms.flip_h = false
			$arms.position.x = 12
			$Area2D/CollisionShape2D.position.x  = 67
	else:
		# If we are shooting/reloading/waiting, ensure we stop moving
		velocity.x = 0

	move_and_slide()

# When the timer finishes waiting, pick a new target
func _on_timer_timeout() -> void:
	if not shootingArea and not is_reloading:
		choose_target()

func shoot():
	is_shooting = true
	velocity.x = 0
	
	var bulletScene = preload("res://Levels/Runner Boss/bulet.tscn")
	var bullet = bulletScene.instantiate()
	
	# Uses the assigned player export, falls back to hardcoded path if empty
	if plr:
		bullet.plr_pos = plr.global_position + Vector2(0,-5)
	else:
		bullet.plr_pos = $"../bunbun".global_position + Vector2(0,-5)
		
	call_deferred("add_child", bullet)
	
	bullet.hit.connect(get_parent().hurt)
	
	if $body.flip_h == true:
		bullet.scale.x=-1
	else:
		bullet.scale.x=1
	
	bullet.global_position = $arms.position + Vector2(0,-25)
	
	ani.play("Shoot")
	bullets -= 1
	
	timershoot.start(1.0)
	await timershoot.timeout
	is_shooting = false # Ready to shoot or check status again next frame

func reload():
	is_reloading = true
	velocity.x = 0
	
	ani.play("reload")
	
	# Wait for the reload animation to actually finish before giving bullets back!
	if ani.has_animation("reload"):
		await ani.animation_finished
	else:
		# Fallback timer if there is no reload animation length
		await get_tree().create_timer(1.5).timeout 
		
	bullets = 2
	is_reloading = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		shootingArea = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("plr"):
		shootingArea = false
