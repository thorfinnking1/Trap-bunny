extends Area2D

@export_file("*.tscn") var SceneTeleportTo : String

@export var CLayer:CanvasLayer
@export var id:int
@export var plr:CharacterBody2D

var ConsentScene = preload("res://MainMap/consent_screen.tscn")

func TeleportConsent():
	plr.moving=false
	var Consent = ConsentScene.instantiate()
	CLayer.add_child(Consent)
	Consent.writeup(Gl.levels[id][0],Gl.levels[id][1],Gl.levels[id][2])
	Consent.scene=SceneTeleportTo
	Consent.plr=plr
	Consent.currentpos=plr.global_position

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		TeleportConsent()
