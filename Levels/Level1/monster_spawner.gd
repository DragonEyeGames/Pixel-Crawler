extends Node2D

enum types {
	weak,
	normal
}

@export var strength: types

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(strength==types.weak):
		var enemy = $Weak.get_children().pick_random()
		var global = enemy.global_position
		$Weak.remove_child(enemy)
		$"../Y_Sorting".add_child(enemy)
		enemy.global_position=global
		
		#queue_free()
	if(strength==types.normal):
		var enemy = $Normal.get_children().pick_random()
		var global = enemy.global_position
		$Normal.remove_child(enemy)
		$"../Y_Sorting".add_child(enemy)
		enemy.global_position=global
		#queue_free()
	await get_tree().process_frame
	call_deferred("queue_free")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
