extends Control


func _on_knight_pressed() -> void:
	GameManager.playerType=GameManager.playerTypes.Knight
	GameManager.playerMaxHealth=20.0
	GameManager.playerSpeed=12.0
	GameManager.playerStrength=13.0
	GameManager.playerHealth=GameManager.playerMaxHealth
	loadScene()


func _on_axeman_pressed() -> void:
	GameManager.playerType=GameManager.playerTypes.Axeman
	GameManager.playerMaxHealth=15.0
	GameManager.playerSpeed=10.0
	GameManager.playerStrength=20.0
	GameManager.playerHealth=GameManager.playerMaxHealth
	loadScene()
	
func loadScene():
	var tween=create_tween()
	tween.tween_property($Fade/Control, "modulate:a", 1, .1)
	await get_tree().create_timer(.1).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://load.tscn")


func _on_archer_pressed() -> void:
	GameManager.playerType=GameManager.playerTypes.Archer
	GameManager.playerMaxHealth=7.0
	GameManager.playerSpeed=14.0
	GameManager.playerStrength=14.0
	GameManager.playerHealth=GameManager.playerMaxHealth
	get_tree().change_scene_to_file("res://Dungeon.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")
