extends Node2D

@export var enemies=3
var emitted:=false

func _ready() -> void:
	SignalBus.enemy_died.connect(on_death)
	get_tree().paused=true
	await get_tree().create_timer(.3).timeout
	get_tree().paused=false
	
func on_death():
	enemies-=1
	if(enemies<=0 and not emitted):
		emitted=true
		SignalBus.allGone.emit()
