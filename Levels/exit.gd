extends Sprite2D

var colliding:=false

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Interact") and colliding):
		entered()
		
		
func entered():
	$Seen.visible=false
	GameManager.player.canMove=false
	GameManager.player.flip("left")
	GameManager.player.sprite.play("walk")
	GameManager.player.get_node("Cam").position_smoothing_enabled=false
	var tween=create_tween()
	tween.tween_property(GameManager.player, "global_position", $Marker2D.global_position, .3)
	await get_tree().create_timer(.3).timeout
	GameManager.player.reparent($Control)
	GameManager.player.global_position=$Marker2D.global_position
	var tween2 = create_tween()
	tween2.tween_property(GameManager.player, "global_position", $End.global_position, 1)
	await get_tree().create_timer(.6).timeout
	GameManager.transition.play("out")
	await get_tree().create_timer(.6).timeout
	await get_tree().process_frame
	await get_tree().process_frame
	GameManager.playerPos=null
	get_tree().change_scene_to_file("res://Scenes/finished.tscn")
		
func _on_area_2d_area_entered(_area: Area2D) -> void:
	colliding=true
	$Seen.visible=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	colliding=false
	$Seen.visible=false


func _on_area_2d_2_area_entered(_area: Area2D) -> void:
	entered()
