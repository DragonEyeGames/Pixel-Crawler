extends Control


func _on_button_pressed() -> void:
	GameManager.playerHealth=GameManager.playerMaxHealth
	get_tree().change_scene_to_file("res://Levels/Level1/Level0.tscn")
