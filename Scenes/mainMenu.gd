extends Control


func _ready() -> void:
	var data = ResourceLoader.load("user://scene_data.tres") as SceneData
	if(data!=null):
		#GameManager.save=data.savedArray
		pass
	else:
		$"VBoxContainer/Load Game".visible=false

func _on_button_pressed() -> void:
	var path := "user://scene_data.tres"
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(path)
	get_tree().change_scene_to_file("res://Scenes/characterSelect.tscn")


func _on_load_game_pressed() -> void:
	var data = ResourceLoader.load("user://scene_data.tres") as SceneData
	GameManager.save=data.savedArray
	GameManager.playerHealth=data.playerHealth
	GameManager.playerMaxHealth=data.playerMaxHealth
	GameManager.playerSpeed=data.playerSpeed
	GameManager.playerStrength=data.playerStrength
	get_tree().change_scene_to_file(data.playerScene)
