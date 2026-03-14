extends CanvasLayer

var paused=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SettingsMenu/Close.modulate=Color.WEB_GRAY
	$"SettingsMenu/SFX Bar".value=GameManager.sfxVolume
	$"SettingsMenu/Music Bar".value=GameManager.musicVolume
	$"SettingsMenu/Master Bar".value=GameManager.masterVolume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Pause")):
		paused=!paused
		get_tree().paused=paused
		AudioServer.set_bus_effect_enabled(2, 0, paused)
		AudioServer.set_bus_effect_enabled(2, 1, paused)
		if(paused):
			visible=true
			var tween=create_tween()
			tween.tween_property($Control, "modulate:a", 1, .1)
		elif(!paused):
			visible=true
			var tween=create_tween()
			tween.tween_property($Control, "modulate:a", 0, .1)
			await get_tree().create_timer(.1).timeout
			await get_tree().process_frame
			visible=false


func _on_resume_pressed() -> void:
	paused=false
	get_tree().paused=paused
	AudioServer.set_bus_effect_enabled(2, 0, paused)
	AudioServer.set_bus_effect_enabled(2, 1, paused)
	visible=true
	var tween=create_tween()
	tween.tween_property($Control, "modulate:a", 0, .1)
	await get_tree().create_timer(.1).timeout
	await get_tree().process_frame
	visible=false


func _on_settings_pressed() -> void:
	if($SettingsMenu.modulate.a!=1):
		$SettingsMenu.visible=true
		var tween=create_tween()
		tween.tween_property($SettingsMenu, "modulate:a", 1, .1)


func _on_menu_pressed() -> void:
	paused=false
	get_tree().paused=paused
	AudioServer.set_bus_effect_enabled(2, 0, paused)
	AudioServer.set_bus_effect_enabled(2, 1, paused)
	get_tree().change_scene_to_file("res://MainMenu.tscn")
	
func _on_close_mouse_entered() -> void:
	var tween=create_tween()
	tween.tween_property($SettingsMenu/Close, "modulate", Color.WHITE, .1)


func _on_close_mouse_exited() -> void:
	var tween=create_tween()
	tween.tween_property($SettingsMenu/Close, "modulate", Color.WEB_GRAY, .1)
	
func _on_close_pressed() -> void:
	if($SettingsMenu.modulate.a!=0):
		var tween=create_tween()
		tween.tween_property($SettingsMenu, "modulate:a", 0, .1)
	await get_tree().create_timer(.1).timeout
	await get_tree().process_frame
	$SettingsMenu.visible=false


func _on_sfx_bar_value_changed(value: float) -> void:
	GameManager.sfxVolume=value
	var multiplier=1
	if(value==-250):
		value=-6400
	if(value<0):
		value=abs(value)
		multiplier=-1
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sqrt(value)*multiplier)


func _on_music_bar_value_changed(value: float) -> void:
	GameManager.musicVolume=value
	var multiplier=1
	if(value==-250):
		value=-6400
	if(value<0):
		value=abs(value)
		multiplier=-1
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), sqrt(value)*multiplier)


func _on_master_bar_value_changed(value: float) -> void:
	GameManager.masterVolume=value
	var multiplier=1
	if(value==-250):
		value=-6400
	if(value<0):
		value=abs(value)
		multiplier=-1
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), sqrt(value)*multiplier)

func _on_resume_mouse_entered() -> void:
	var tween2=create_tween()
	tween2.tween_property($Control/VBoxContainer/Resume/Resume, "scale", Vector2(6.2, 5.162), .1)


func _on_resume_mouse_exited() -> void:
	var tween2=create_tween()
	tween2.tween_property($Control/VBoxContainer/Resume/Resume, "scale", Vector2(5.72, 4.762), .1)


func _on_settings_mouse_entered() -> void:
	var tween2=create_tween()
	tween2.tween_property($Control/VBoxContainer/Settings/Settings, "scale", Vector2(6.2, 5.162), .1)


func _on_settings_mouse_exited() -> void:
	var tween2=create_tween()
	tween2.tween_property($Control/VBoxContainer/Settings/Settings, "scale", Vector2(5.72, 4.762), .1)


func _on_menu_mouse_entered() -> void:
	var tween2=create_tween()
	tween2.tween_property($Control/VBoxContainer/Menu/Menu, "scale", Vector2(6.2, 5.162), .1)


func _on_menu_mouse_exited() -> void:
	var tween2=create_tween()
	tween2.tween_property($Control/VBoxContainer/Menu/Menu, "scale", Vector2(5.72, 4.762), .1)
