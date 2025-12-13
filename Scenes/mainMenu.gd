extends Control


func _ready() -> void:
	var data = ResourceLoader.load("user://scene_data.tres") as SceneData
	if(data!=null):
		GameManager.save=true

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/characterSelect.tscn")
