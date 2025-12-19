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
