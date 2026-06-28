extends Control

var scene:String
var currentpos:Vector2
var plr:CharacterBody2D
@onready var nams: RichTextLabel = $names
@onready var difficuly: RichTextLabel = $difficuly
@onready var stars_rate: Sprite2D = $StarsRate

func writeup(names:String,difficulty:String,level:int)->void:
	nams.text=names
	difficuly.text=difficulty
	stars_rate.frame=level

func _on_yes_pressed() -> void:
	Gl.player_position=currentpos
	Scenemanager.leave(scene,"fade")
	queue_free()


func _on_no_pressed() -> void:
	plr.moving=true
	queue_free()
