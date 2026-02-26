@icon("res://Assets/GodotIcon/icon_door.png")
extends AnimatedSprite2D
@export var chapter=1
@export var toTransport:=2
@export var playerPos:= Vector2.ZERO
@export var enemyControlled:=false
@export var level = 2
@export var direction: String
@export var coverUp: Node2D
var connection

func _ready() -> void:
	if(enemyControlled):
		SignalBus.allGone.connect(openDoor)
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

func _on_area_2d_area_entered(area: Area2D) -> void:
	pass
	#if(area.get_parent() is Player):
		#get_parent().visible=!get_parent().visible;
		
func _process(delta: float) -> void:
	if(coverUp!=null):
		coverUp.visible=!visible

func saveGame(): #Old undedned stuf I don;t want to ocmment out or delete
		var enemies = get_tree().get_nodes_in_group("Enemy")
		var data = SceneData.new()
		GameManager.playerPos=playerPos
		if(not level in GameManager.save):
			GameManager.save.append(level)
		if ResourceLoader.exists("user://scene_data.tres"):
			var oldData = ResourceLoader.load("user://scene_data.tres") as SceneData
			data.enemyArray=oldData.enemyArray
			data.enemyArray[0][level]=[]
		for enemy in enemies:
			if(not enemy.dead):
				var enemyScene = PackedScene.new()
				enemyScene.pack(enemy)
				data.enemyArray[0][level].append(enemyScene)
		data.playerPosition=playerPos
		data.playerHealth=GameManager.player.health
		data.playerMaxHealth=GameManager.playerMaxHealth
		data.playerSpeed=GameManager.playerSpeed
		data.playerStrength=GameManager.playerStrength
		data.playerScene="res://Levels/Level" + str(chapter) + "/Level" + str(toTransport) +".tscn"
		data.savedArray=GameManager.save
		data.playerType=GameManager.playerType
		data.playerGold=GameManager.playerGold
		data.playerInventory=GameManager.playerInventory.duplicate()
		ResourceSaver.save(data, "user://scene_data.tres")
		get_tree().change_scene_to_file("res://Levels/Level" + str(chapter) + "/Level" + str(toTransport) +".tscn")
