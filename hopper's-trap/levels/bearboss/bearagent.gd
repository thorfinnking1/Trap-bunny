extends Node2D

@onready var bearani: AnimationPlayer = $bearani
@onready var bunbun: CharacterBody2D = $bunbun
@onready var bear: Node2D = $bear
@onready var hitanimation: AnimationPlayer = $hitanimation
const DEADSCREEN = preload("uid://dpuabxnjo6c4p")
@onready var canvas_layer: CanvasLayer = $CanvasLayer

var sleeping=0
var bearhp=0
var hp=2
var tries=5
var amount=0
var die=false
var won=false

func _process(delta: float) -> void:
	if sleeping==2 and not die:
		bear.global_position.x=lerp(bear.global_position.x,bunbun.global_position.x,delta)
		if (bear.global_position.x-bunbun.global_position.x)<0:
			bear.scale.x=-2
		else:
			bear.scale.x=2
	if bearhp>=46 and not won and not die:
		won=true
		Gl.levels[3][2]=hp+1
		Scenemanager.leave("res://MainMap/map.tscn","circle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr") and sleeping==0 and not die:
		bearani.play("waking up")
		sleeping=1
		await bearani.animation_finished
		bearani.play("walkingaround")
		sleeping=2

func _on_find_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr") and sleeping==2:
		amount+=1
		sleeping=3
		bearani.play("attack")
		bearhp+=3.066
		await bearani.animation_finished
		if amount>=tries:
			bearani.play_backwards("waking up")
			amount=0
			sleeping=0
		else:
			bearani.play("walkingaround")
			sleeping=2

func dead()->void:
	if hp<=0 and not die and not won:
		var deadscreen=DEADSCREEN.instantiate()
		canvas_layer.add_child(deadscreen)
		var val=bearhp
		deadscreen.value=val
		die=true
		bear.queue_free()
	hp-=1
	hitanimation.play("hit")

func _on_kill_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		dead()
