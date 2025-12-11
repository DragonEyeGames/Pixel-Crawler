@icon("res://Assets/GodotIcon/icon_door.png")
extends AnimatedSprite2D
@export var enemyControlled:=false

func _ready() -> void:
	if(enemyControlled):
		SignalBus.allGone.connect(openDoor)

func openDoor():
	play("raise")
	$StaticBody2D/CollisionShape2D.disabled=true
