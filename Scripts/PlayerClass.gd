extends CharacterBody2D
class_name Player

var sprite: AnimatedSprite2D
var shadow: AnimatedSprite2D
@export var speed := 80.0
@export var damage:=1.0
@export var strength=1
@export var health:=10.0
@export var attackSpeed:=1.1
var attacking:=false
var direction:="right"
var animator:AnimationPlayer
var hitAnimator: AnimationPlayer
var dead:=false
var canMove=true

func  initialize() -> void:
	GameManager.player=self
	hitAnimator=$Hit
	sprite=$Player
	shadow=$Shadow
	animator=$Attack
	#Loading from Game Manager
	health=GameManager.playerHealth
	if(GameManager.playerPos!=null):
		global_position=GameManager.playerPos
		GameManager.playerPos=null
	speed=GameManager.playerSpeed*9
	strength=GameManager.playerStrength/10
	attackSpeed=GameManager.playerSpeed/10
	
func hit(newDamage):
	newDamage=calculateResistance(newDamage)
	if(dead):
		return
	$HitSound.pitch_scale=randf_range(.9, 1.1)
	$HitSound.play()
	Engine.time_scale = 0.05
	health-=newDamage
	hitAnimator.play("hit")
	GameManager.playerHealth=health
	await get_tree().create_timer(0.02, true).timeout
	Engine.time_scale = 1.0
	if(health<=0):
		dead=true
		Engine.time_scale = .2
		var tween=create_tween()
		tween.tween_property(Engine, "time_scale", 1.0, 2)
		sprite.play("die")
		shadow.play("die")
		await get_tree().create_timer(1.5).timeout
		hitAnimator.play("die")
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://Scenes/dead.tscn")

func calculateResistance(calculatedDamage):
	if(GameManager.inventoryItems.Armour in GameManager.playerInventory):
		return calculatedDamage*.7
	elif(GameManager.inventoryItems.Tunic in GameManager.playerInventory):
		return calculatedDamage*.9
	else:
		return calculatedDamage
