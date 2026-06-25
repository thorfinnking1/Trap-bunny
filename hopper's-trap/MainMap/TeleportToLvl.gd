extends Area2D

@export_file("*.tscn") var SceneTeleportTo : String

@export var CLayer:CanvasLayer

var ConsentScene = preload("res://MainMap/consent_screen.tscn")

func TeleportConsent():
	var Consent = ConsentScene.instantiate()
	CLayer.add_child(Consent)
	Consent.scene=SceneTeleportTo

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		TeleportConsent()
