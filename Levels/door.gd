@icon("res://Assets/GodotIcon/icon_door.png")
extends AnimatedSprite2D
@export var toTransport:=2
@export var playerPos:= Vector2.ZERO
@export var enemyControlled:=false

func _ready() -> void:
	if(enemyControlled):
		SignalBus.allGone.connect(openDoor)
		$StaticBody2D/CollisionShape2D.disabled=false
		play("closed")
		await get_tree().process_frame
		play("closed")
	else:
		play("open")
		await get_tree().process_frame
		play("open")

func openDoor():
	play("raise")
	$StaticBody2D/CollisionShape2D.disabled=true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent() is Player):
		GameManager.transition.play("out")
		area.get_parent().canMove=false
		await get_tree().create_timer(.5).timeout
		await get_tree().process_frame
		await get_tree().process_frame
		GameManager.playerPos=playerPos
		get_tree().change_scene_to_file("res://Levels/Level" + str(toTransport) + ".tscn")
