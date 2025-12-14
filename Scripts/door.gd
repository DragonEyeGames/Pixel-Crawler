@icon("res://Assets/GodotIcon/icon_door.png")
extends AnimatedSprite2D
@export var transportLevel=1
@export var toTransport:=2
@export var playerPos:= Vector2.ZERO
@export var enemyControlled:=false
@export var level = 2

func _ready() -> void:
	if(enemyControlled):
		SignalBus.allGone.connect(openDoor)
		$StaticBody2D/CollisionShape2D.disabled=false
		play("closed")
		await get_tree().process_frame
		play("closed")
	else:
		play("open")
		await get_tree().process_frame
		play("open")

func openDoor():
	await get_tree().process_frame
	await get_tree().process_frame
	play("raise")
	$StaticBody2D/CollisionShape2D.disabled=true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent() is Player):
		GameManager.transition.play("out")
		area.get_parent().canMove=false
		await get_tree().create_timer(.5).timeout
		await get_tree().process_frame
		await get_tree().process_frame
		var enemies = get_tree().get_nodes_in_group("Enemy")
		var data = SceneData.new()
		GameManager.playerPos=playerPos
		if(not level in GameManager.save):
			GameManager.save.append(level)
		for enemy in enemies:
			var enemyScene = PackedScene.new()
			enemyScene.pack(enemy)
			data.enemyArray[0][level].append(enemyScene)
		data.playerPosition=playerPos
		data.playerHealth=GameManager.player.health
		data.playerMaxHealth=GameManager.playerMaxHealth
		data.playerSpeed=GameManager.playerSpeed
		data.playerStrength=GameManager.playerStrength
		data.playerScene="res://Levels/Level" + str(transportLevel) + "/Level" + str(toTransport) +".tscn"
		data.savedArray=GameManager.save
		data.playerType=GameManager.playerType
		ResourceSaver.save(data, "user://scene_data.tres")
		get_tree().change_scene_to_file("res://Levels/Level" + str(transportLevel) + "/Level" + str(toTransport) +".tscn")
