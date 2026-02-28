@icon("res://Assets/GodotIcon/icon_chest.png")
extends AnimatedSprite2D

var collided=false
var opened=false
@export var gold := 20
@export var active=true

func _process(_delta: float) -> void:
	if(!active):
		return
	if(collided and Input.is_action_just_pressed("Interact") and not opened):
		opened=true
		play("open")
		$Open.emitting=true
		$Jingle.pitch_scale=randf_range(1, 1.1)
		$Jingle.play()
		GameManager.playerGold+=randi_range(gold-5, gold+5)

func _on_area_2d_area_entered(_area: Area2D) -> void:
	collided=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	collided=false
