extends Node2D

func _ready():
	match GameManager.playerType:
		GameManager.playerTypes.Knight:
			var knight = $Knight
			var cam = $Cam
			cam.call_deferred("reparent", knight)
			knight.call_deferred("reparent", get_parent())
			cam.position=Vector2.ZERO
			cam.position_smoothing_enabled=false
			await get_tree().process_frame
			await get_tree().process_frame
			cam.position_smoothing_enabled=true
			call_deferred("queue_free")
		GameManager.playerTypes.Axeman:
			var knight = $Axeman
			var cam = $Cam
			cam.call_deferred("reparent", knight)
			knight.call_deferred("reparent", get_parent())
			cam.position=Vector2.ZERO
			cam.position_smoothing_enabled=false
			await get_tree().process_frame
			await get_tree().process_frame
			cam.position_smoothing_enabled=true
			call_deferred("queue_free")
