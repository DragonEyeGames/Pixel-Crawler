@icon("res://Assets/GodotIcon/icon_chest.png")
extends AnimatedSprite2D

var collided=false
var opened=false

func _process(_delta: float) -> void:
	if(collided and Input.is_action_just_pressed("Interact") and not opened):
		opened=true
		play("open")

func _on_area_2d_area_entered(_area: Area2D) -> void:
	collided=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	collided=false
