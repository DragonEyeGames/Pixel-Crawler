extends TileMapLayer


func _on_area_2d_area_entered(_area: Area2D) -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", .3, .1)


func _on_area_2d_area_exited(_area: Area2D) -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, .1)
