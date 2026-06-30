extends CharacterBody2D

var speed = 200
var plr_pos : Vector2

func _ready() -> void:
	var direction = (plr_pos - global_position).normalized()
	velocity = direction * speed
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
