extends Node2D

func _ready():
	match GameManager.playerType:
		GameManager.playerTypes.Knight:
			var knight = $Knight
			knight.initialize()
			var cam = $Cam
			cam.position_smoothing_enabled=false
			cam.call_deferred("reparent", knight)
			knight.call_deferred("reparent", get_parent())
			cam.position=Vector2.ZERO
			await get_tree().process_frame
			cam.position=Vector2.ZERO
			call_deferred("queue_free")
		GameManager.playerTypes.Axeman:
			var axeman = $Axeman
			axeman.initialize()
			var cam = $Cam
			cam.position_smoothing_enabled=false
			cam.call_deferred("reparent", axeman)
			axeman.call_deferred("reparent", get_parent())
			cam.position=Vector2.ZERO
			await get_tree().process_frame
			cam.position=Vector2.ZERO
			call_deferred("queue_free")
