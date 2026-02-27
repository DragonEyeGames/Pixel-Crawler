extends Node2D

func _ready() -> void:
	spikes()
	
func spikes():
	await get_tree().create_timer(2).timeout
	for child in get_children():
		child.extrude()
	await get_tree().create_timer(1).timeout
	for child in get_children():
		child.retract()
	spikes()
