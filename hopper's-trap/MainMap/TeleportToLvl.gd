extends Area2D

@export var SceneTeleportTo : String

@onready var player: CharacterBody2D = %Player

var ConsentScene = preload("res://MainMap/consent_screen.tscn")

func TeleportConsent():
	var Consent = ConsentScene.instantiate()
	player.add_child(Consent)
	Consent.global_position = player.global_position

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		Gl.Scene = SceneTeleportTo
		TeleportConsent()
