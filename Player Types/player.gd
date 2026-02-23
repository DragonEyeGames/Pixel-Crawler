extends Node2D

func _ready():
	if(GameManager.playerPos!=null):
		global_position=GameManager.playerPos
	match GameManager.playerType:
		GameManager.playerTypes.Knight:
			print("knight")
			var knight = $Knight
			knight.initialize()
			var cam = $Cam
			cam.position_smoothing_enabled=false
			cam.call_deferred("reparent", knight)
			knight.call_deferred("reparent", get_parent())
			cam.position=Vector2.ZERO
			await get_tree().process_frame
			cam.position=Vector2.ZERO
			cam.position_smoothing_enabled=true
			call_deferred("queue_free")
		GameManager.playerTypes.Axeman:
			print("axeman")
			var axeman = $Axeman
			axeman.initialize()
			var cam = $Cam
			cam.position_smoothing_enabled=false
			cam.call_deferred("reparent", axeman)
			axeman.call_deferred("reparent", get_parent())
			cam.position=Vector2.ZERO
			await get_tree().process_frame
			cam.position=Vector2.ZERO
			cam.position_smoothing_enabled=true
			call_deferred("queue_free")
		GameManager.playerTypes.Archer:
			print("archer")
			var archer = $Archer
			archer.initialize()
			var cam = $Cam
			cam.position_smoothing_enabled=false
			cam.call_deferred("reparent", archer)
			archer.call_deferred("reparent", get_parent())
			cam.position=Vector2.ZERO
			await get_tree().process_frame
			cam.position=Vector2.ZERO
			cam.position_smoothing_enabled=true
			call_deferred("queue_free")
