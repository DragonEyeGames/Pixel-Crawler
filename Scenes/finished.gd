extends Control


func _on_button_pressed() -> void:
	GameManager.playerHealth=GameManager.playerMaxHealth
	var path := "user://scene_data.tres"
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(path)
	get_tree().change_scene_to_file("res://Scenes/mainMenu.tscn")
