extends Control

@export var fireVolume=-30
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SettingsMenu/Close.modulate=Color.WEB_GRAY
	var path := "user://volume_data.tres"
	if FileAccess.file_exists(path):
		var data = ResourceLoader.load("user://volume_data.tres") as VolumeData
		GameManager.sfxVolume=data.sfxVolume
		GameManager.musicVolume=data.musicVolume
		GameManager.masterVolume=data.masterVolume
	$"SettingsMenu/SFX Bar".value=GameManager.sfxVolume
	$"SettingsMenu/Music Bar".value=GameManager.musicVolume
	$"SettingsMenu/Master Bar".value=GameManager.masterVolume


func _on_start_pressed() -> void:
	var data=VolumeData.new()
	data.sfxVolume=GameManager.sfxVolume
	data.musicVolume=GameManager.musicVolume
	data.masterVolume=GameManager.masterVolume
	ResourceSaver.save(data, "user://volume_data.tres")
	get_tree().change_scene_to_file("res://Scenes/characterSelect.tscn")


func _on_settings_pressed() -> void:
	if($SettingsMenu.modulate.a!=1):
		$SettingsMenu.visible=true
		var tween=create_tween()
		tween.tween_property($SettingsMenu, "modulate:a", 1, .1)
	


func _on_start_mouse_entered() -> void:
	var tween=create_tween()
	tween.tween_property($Start/FireSprite2, "modulate:a", 1, .1)
	var tween2=create_tween()
	tween2.tween_property($Start, "scale", Vector2(8.668, 7.216), .1)
	var tween3=create_tween()
	tween3.tween_property($StartFire, "volume_db", fireVolume, .1)


func _on_start_mouse_exited() -> void:
	var tween=create_tween()
	tween.tween_property($Start/FireSprite2, "modulate:a", 0, .1)
	var tween2=create_tween()
	tween2.tween_property($Start, "scale", Vector2(7.88, 6.56), .1)
	var tween3=create_tween()
	tween3.tween_property($StartFire, "volume_db", -80, .1)


func _on_settings_mouse_entered() -> void:
	var tween=create_tween()
	tween.tween_property($Settings/FireSprite2, "modulate:a", 1, .1)
	var tween2=create_tween()
	tween2.tween_property($Settings, "scale", Vector2(8.668, 7.216), .1)
	var tween3=create_tween()
	tween3.tween_property($SettingsFire, "volume_db", fireVolume, .1)


func _on_settings_mouse_exited() -> void:
	var tween=create_tween()
	tween.tween_property($Settings/FireSprite2, "modulate:a", 0, .1)
	var tween2=create_tween()
	tween2.tween_property($Settings, "scale", Vector2(7.88, 6.56), .1)
	var tween3=create_tween()
	tween3.tween_property($SettingsFire, "volume_db", -80, .1)


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
