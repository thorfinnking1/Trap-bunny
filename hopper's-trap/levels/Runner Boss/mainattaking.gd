extends Node2D

var bosshp=0.0
var hp=2
var dead=false

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var hitanimation: AnimationPlayer = $hitanimation

@onready var health_and_slash: Sprite2D = $HealthAndSlash
const DEADSCREEN = preload("uid://dpuabxnjo6c4p")

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		bosshp+=10.0
		health_and_slash.frame=int(5.0*(bosshp/100))
		if bosshp>=100:
			Gl.levels[1][2]=hp
			Scenemanager.leave("res://MainMap/map.tscn","circle")

func hurt()->void:
	hp-=1
	if hp<0 and not dead:
		var deadscreen=DEADSCREEN.instantiate()
		canvas_layer.add_child(deadscreen)
		var val=46*(bosshp/100)
		deadscreen.value=val
		dead=true
	hitanimation.play("hit")
		
