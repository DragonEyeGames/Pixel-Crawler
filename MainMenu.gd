extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/characterSelect.tscn")


func _on_settings_pressed() -> void:
	if($SettingsMenu.modulate.a!=1):
		var tween=create_tween()
		tween.tween_property($SettingsMenu, "modulate:a", 1, .1)
	


func _on_start_mouse_entered() -> void:
	var tween=create_tween()
	tween.tween_property($Start/FireSprite2, "modulate:a", 1, .1)
	var tween2=create_tween()
	tween2.tween_property($Start, "scale", Vector2(8.668, 7.216), .1)


func _on_start_mouse_exited() -> void:
	var tween=create_tween()
	tween.tween_property($Start/FireSprite2, "modulate:a", 0, .1)
	var tween2=create_tween()
	tween2.tween_property($Start, "scale", Vector2(7.88, 6.56), .1)


func _on_settings_mouse_entered() -> void:
	var tween=create_tween()
	tween.tween_property($Settings/FireSprite2, "modulate:a", 1, .1)
	var tween2=create_tween()
	tween2.tween_property($Settings, "scale", Vector2(8.668, 7.216), .1)


func _on_settings_mouse_exited() -> void:
	var tween=create_tween()
	tween.tween_property($Settings/FireSprite2, "modulate:a", 0, .1)
	var tween2=create_tween()
	tween2.tween_property($Settings, "scale", Vector2(7.88, 6.56), .1)
