extends Control


func _on_knight_pressed() -> void:
	GameManager.playerType=GameManager.playerTypes.Knight
	GameManager.playerMaxHealth=20.0
	GameManager.playerSpeed=8.0
	GameManager.playerStrength=12.0
	GameManager.playerHealth=GameManager.playerMaxHealth
	get_tree().change_scene_to_file("res://Levels/Level1/Level0.tscn")


func _on_axeman_pressed() -> void:
	GameManager.playerType=GameManager.playerTypes.Axeman
	GameManager.playerMaxHealth=15.0
	GameManager.playerSpeed=7.0
	GameManager.playerStrength=20.0
	GameManager.playerHealth=GameManager.playerMaxHealth
	get_tree().change_scene_to_file("res://Levels/Level1/Level0.tscn")
