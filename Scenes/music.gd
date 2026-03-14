extends Node2D

var backupPause=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if get_tree().paused:
		$Paused.seek($Music.get_playback_position())
	if(backupPause!=get_tree().paused):
		backupPause=get_tree().paused
		if(get_tree().paused):
			print("paused")
			print("music:", $Music.get_playback_position(), " paused:", $Paused.get_playback_position())
			$Music.volume_db=-80
			$Paused.volume_db=-27.67
			var pos = $Music.get_playback_position()
			#$Music.stop()
			$Paused.seek(pos)

		else:
			$Music.volume_db=-27.67
			$Paused.volume_db=-80
