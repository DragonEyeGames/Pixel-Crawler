extends Node2D

@export var level:=0
@export var chapter=1
@export var enemies=3
var emitted:=false
@export var doors: Array[Node2D] = []
var colliding=false
var active=false
func _ready() -> void:
	for door in doors:
		door.level=level
		door.chapter=chapter
	SignalBus.enemy_died.connect(on_death)
	SignalBus.generated.connect(finishedGeneration)
	await get_tree().process_frame
	await get_tree().process_frame
	for child in $Y_Sorting.get_children():
		var global_pos = child.global_position
		$Y_Sorting.remove_child(child)
		$"../Y-Sort".add_child(child)
		child.global_position = global_pos
		if(child is Enemy):
			child.mainParent=self;
	#if ResourceLoader.exists("user://scene_data.tres"):
		#var data = ResourceLoader.load("user://scene_data.tres") as SceneData
		#if(level in GameManager.save):
			#for enemy in get_tree().get_nodes_in_group("Enemy"):
				#enemy.queue_free()
			#enemies=0
			#for enemy in data.enemyArray[0][level]:
				#var newEnemy=enemy.instantiate()
				#$Y_Sorting.add_child(newEnemy)
				#enemies+=1
			#if(enemies<=0):
				#emitted=true
				#SignalBus.allGone.emit()
	#get_tree().paused=true
	#await get_tree().create_timer(.3).timeout
	#get_tree().paused=false
	
func on_death():
	pass
	#enemies-=1
	#if(enemies<=0 and not emitted):
		#emitted=true
		#SignalBus.allGone.emit()


func _on_area_2d_area_entered(_area: Area2D) -> void:
	colliding=true
	
func finishedGeneration():
	for door in doors:
		door.visible=false

func _on_player_area_entered(_area: Area2D) -> void:
	modulate.a=0
	visible=true
	var tween=create_tween()
	tween.tween_property(self, "modulate:a", 1.0, .1)
	active=true

func _on_player_area_exited(_area: Area2D) -> void:
	modulate.a=1
	visible=true
	var tween=create_tween()
	tween.tween_property(self, "modulate:a", 0.0, .1)
	active=false
