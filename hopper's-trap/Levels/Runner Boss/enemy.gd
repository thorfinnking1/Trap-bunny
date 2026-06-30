extends CharacterBody2D

var speed = 100
var movement = RandomNumberGenerator.new()
var moving = false
var shootingArea = false
var target_x = 0.0
var is_reloading = false

@export var bullets : int
@export var plr : CharacterBody2D

@onready var timershoot: Timer = $timershoot
@onready var timer: Timer = $Timer
@onready var ani: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# Connect the timer signal if you didn't do it in the editor
	timer.timeout.connect(_on_timer_timeout)
	choose_target()

func choose_target():
	target_x = movement.randi_range(76, 490)
	moving = true

func _physics_process(_delta: float) -> void:

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
			$Area2D/CollisionShape2D.position.x  = -67
		else :
			$body.flip_h  = false
			$arms.flip_h = false
			$arms.position.x = 12
			$Area2D/CollisionShape2D.position.x  = 67
	
	move_and_slide()

# 3. When the timer finishes waiting, pick a new target
func _on_timer_timeout() -> void:
	if !shootingArea:
		choose_target()

func shoot():
	if shootingArea and bullets !=0:
		var bulletScene = preload("res://Levels/Runner Boss/bulet.tscn")
		var bullet = bulletScene.instantiate()
		bullet.plr_pos = $"../bunbun".global_position+Vector2(0,-5)
		call_deferred("add_child",bullet)
		bullet.global_position = $arms.position +Vector2(0,-25)
		ani.play("Shoot")
		bullets -=1
		timershoot.start(1)
		await timershoot.timeout
		shoot()

func _process(_delta: float) -> void:
	# Only reload if out of bullets AND we aren't already reloading
	if shootingArea and bullets>=2:
		velocity.x = 0
		ani.play("RESET")
		if bullets >=1:
			shoot()
		else:
			is_reloading=false
	elif bullets <= 0 and not is_reloading:
		reload()

func reload():
	is_reloading = true # Lock the reload process
	
	ani.play("reload")
	bullets=2
	
	await ani.animation_finished

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		shootingArea = true
		
		#if !ani.is_playing():

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("plr"):
		shootingArea = false
