extends Node2D

var selected

func _ready():
	SignalBus.generated.connect(finishedGeneration)
	if(GameManager.playerPos!=null):
		global_position=GameManager.playerPos
	match GameManager.playerType:
		GameManager.playerTypes.Knight:
			print("knight")
			var knight = $Knight
			selected=knight
			knight.initialize()
			var cam = $Cam
			cam.position_smoothing_enabled=false
			cam.call_deferred("reparent", knight)
			knight.call_deferred("reparent", get_parent())
			cam.position=Vector2.ZERO
			await get_tree().process_frame
			cam.position=Vector2.ZERO
			cam.position_smoothing_enabled=true
		GameManager.playerTypes.Axeman:
			print("axeman")
			var axeman = $Axeman
			selected=axeman
			axeman.initialize()
			var cam = $Cam
			cam.position_smoothing_enabled=false
			cam.call_deferred("reparent", axeman)
			axeman.call_deferred("reparent", get_parent())
			cam.position=Vector2.ZERO
			await get_tree().process_frame
			cam.position=Vector2.ZERO
			cam.position_smoothing_enabled=true
		GameManager.playerTypes.Archer:
			print("archer")
			var archer = $Archer
			selected=archer
			archer.initialize()
			var cam = $Cam
			cam.position_smoothing_enabled=false
			cam.call_deferred("reparent", archer)
			archer.call_deferred("reparent", get_parent())
			cam.position=Vector2.ZERO
			await get_tree().process_frame
			cam.position=Vector2.ZERO
			cam.position_smoothing_enabled=true

func finishedGeneration():
	selected.process_mode=ProcessMode.PROCESS_MODE_INHERIT
	for child in get_children():
		if(child is CharacterBody2D and child!=selected):
			child.queue_free()
	selected.canMove=false
	await get_tree().create_timer(.25).timeout
	selected.canMove=true
	call_deferred("queue_free")
