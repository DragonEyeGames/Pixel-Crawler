@icon("res://Assets/GodotIcon/icon_door.png")
extends AnimatedSprite2D
@export var toTransport:=2

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent() is Player):
		GameManager.transition.play("out")
		area.get_parent().canMove=false
		await get_tree().create_timer(.5).timeout
		await get_tree().process_frame
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://Levels/Level" + str(toTransport) + ".tscn")
