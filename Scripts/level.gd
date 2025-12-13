extends Node2D

@export var level:=0
@export var enemies=3
var emitted:=false

func _ready() -> void:
	for door in get_tree().get_nodes_in_group("Door"):
		door.level=level
	SignalBus.enemy_died.connect(on_death)
	var data = ResourceLoader.load("user://scene_data.tres") as SceneData
	if(level in GameManager.save):
		for enemy in get_tree().get_nodes_in_group("Enemy"):
			enemy.queue_free()
		enemies=0
		for enemy in data.enemyArray[0][level]:
			var newEnemy=enemy.instantiate()
			$Y_Sorting.add_child(newEnemy)
			enemies+=1
		if(enemies<=0):
			emitted=true
			SignalBus.allGone.emit()
	get_tree().paused=true
	await get_tree().create_timer(.3).timeout
	get_tree().paused=false
	
func on_death():
	enemies-=1
	if(enemies<=0 and not emitted):
		emitted=true
		SignalBus.allGone.emit()
