extends Node2D

@export var level:=0
@export var chapter=1
@export var enemies=3
var emitted:=false
@export var doors: Array[Node2D] = []
var colliding=false
var active=false

var toUpdate=[]

func _ready() -> void:
	modulate.a=0
	for door in doors:
		door.level=level
		door.chapter=chapter
	SignalBus.enemy_died.connect(on_death)
	SignalBus.generated.connect(finishedGeneration)
	await get_tree().process_frame
	await get_tree().process_frame
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

func _process(_delta: float) -> void:
	$NavRegion.enabled=active
	$NavRegion.visible=active
	if(has_node("Floor")):
		$Floor.collision_enabled=visible
	else:
		$Control/Floor.collision_enabled=visible
	for child in toUpdate:
		if is_instance_valid(child):
			child.visible = active
		else:
			toUpdate.erase(child)

func _on_area_2d_area_entered(_area: Area2D) -> void:
	colliding=true
	
func finishedGeneration():
	visible=true
	if(get_parent()==null):
		print("BYE")
		queue_free()
		return
	for door in doors:
		door.visible=false
	for child in $Y_Sorting.get_children():
		var global_pos = child.global_position
		$Y_Sorting.remove_child(child)
		$"../Y-Sort".add_child(child)
		child.global_position = global_pos
		if(child is Enemy):
			child.mainParent=self;
		else:
			toUpdate.append(child)

func _on_player_area_entered(_area: Area2D) -> void:
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
