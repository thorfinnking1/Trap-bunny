extends CharacterBody2D

var speed = 200
var plr_pos : Vector2

signal hit

func _ready() -> void:
	var direction = (plr_pos - global_position).normalized()
	velocity = direction * speed
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		hit.emit()
