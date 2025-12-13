extends Node2D

@export var level:=0
@export var enemies=3
var emitted:=false

func _ready() -> void:
	GameManager.save=true
	SignalBus.enemy_died.connect(on_death)
	get_tree().paused=true
	await get_tree().create_timer(.3).timeout
	get_tree().paused=false
	var data = ResourceLoader.load("user://scene_data.tres") as SceneData
	if(GameManager.save):
		for enemy in get_tree().get_nodes_in_group("Enemy"):
			enemy.queue_free()
		for enemy in data.enemyArray[level]:
			var newEnemy=enemy.instantiate()
			$Y_Sorting.add_child(newEnemy)
	
func on_death():
	enemies-=1
	if(enemies<=0 and not emitted):
		emitted=true
		SignalBus.allGone.emit()
