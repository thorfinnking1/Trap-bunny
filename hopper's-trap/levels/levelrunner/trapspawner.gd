extends Node2D

@onready var timer: Timer = $Timer

@onready var hitanimation: AnimationPlayer = $hitanimation

@onready var ground: Node2D = $going
var max_time=20.0
var time=0.0
var hp=2

@onready var burrow: Node2D = $burrow

var play=false
var goodtogo=true
@onready var rich_text_label: RichTextLabel = $RichTextLabel

@onready var bunbun: CharacterBody2D = $bunbun

const DEADSCREEN = preload("uid://dpuabxnjo6c4p")
@onready var canvas_layer: CanvasLayer = $CanvasLayer

const BEARTRAP = preload("uid://b4qbbdekef3q3")
var speed=150

@onready var parallax_2d_3: Parallax2D = $Parallax2D3
@onready var parallax_2d_2: Parallax2D = $Parallax2D2
@onready var parallax_2d: Parallax2D = $Parallax2D

func _process(delta: float) -> void:
	#starts the game
	if not play and Input.get_axis("Up","Down") and goodtogo:
		play=true
		bunbun.jumparound=true
		rich_text_label.visible=false
		timer.autostart=true
		timer.start(1)
	
	if play:
		parallax_2d.autoscroll.x=-150
		parallax_2d_2.autoscroll.x=-50
		parallax_2d_3.autoscroll.x=-10
		for kids in ground.get_children():
			kids.global_position.x-=speed*delta
	else:
		parallax_2d.autoscroll.x=0
		parallax_2d_2.autoscroll.x=0
		parallax_2d_3.autoscroll.x=0

func _on_timer_timeout() -> void:
	if play:
		time+=1
	
	if play and goodtogo:
		for i in range(randi_range(1,2)):
			var trap=BEARTRAP.instantiate()
			ground.add_child(trap)
			trap.time=5
			trap.position=Vector2(0,randf_range(-50,40))
			trap.connect("kill",dead)
		if time>=max_time:
			goodtogo=false
			var child=burrow
			child.get_parent().remove_child(child)
			ground.add_child(child)
			child.position=Vector2(280,0)
	elif time>=max_time+5:
		play=false
		bunbun.visible=false
		Gl.levels[0][2]=hp+1
		Scenemanager.leave("res://MainMap/map.tscn","circle")

func dead()->void:
	if hp<=0 and play:
		play=false
		goodtogo=false
		bunbun.jumparound=false
		var deadscreen=DEADSCREEN.instantiate()
		canvas_layer.add_child(deadscreen)
		var val=time/max_time*41+5
		deadscreen.value=val
	hp-=1
	hitanimation.play("hit")
