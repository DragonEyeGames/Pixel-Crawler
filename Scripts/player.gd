@icon("res://Assets/GodotIcon/icon_character.png")
extends CharacterBody2D
class_name Player

var sprite: AnimatedSprite2D
var shadow: AnimatedSprite2D
@export var speed := 100.0
@export var damage=1
@export var health=10
var attacking:=false
var direction:="right"
var animator:AnimationPlayer
var hitAnimator: AnimationPlayer
var dead:=false
var canMove=true


func  _ready() -> void:
	health=GameManager.playerHealth
	if(GameManager.playerPos!=null):
		global_position=GameManager.playerPos
		GameManager.playerPos=null
	GameManager.player=self
	hitAnimator=$Hit
	sprite=$Player
	shadow=$Shadow
	animator=$Attack
	$Cam.position_smoothing_enabled=false
	await get_tree().process_frame
	await get_tree().process_frame
	$Cam.position_smoothing_enabled=true
	
func _physics_process(_delta: float) -> void:
	if(dead or not canMove or attacking):
		return
	velocity = Input.get_vector("Left", "Right", "Up", "Down")
	velocity*=speed
	move_and_slide()
	if(velocity == Vector2.ZERO and sprite.animation=="walk" and attacking==false):
		sprite.play("idle")
	if(velocity != Vector2.ZERO and sprite.animation=="idle" and attacking==false):
		sprite.play("walk")
	if(velocity.x<0 and direction=="right"):
		flip("left")
	if(velocity.x>0 and direction=="left"):
		flip("right")
	if(Input.is_action_just_pressed("Attack") and attacking==false):
		attacking=true
		if(randi_range(1, 10)==10):
			sprite.play("attack-2")
			animator.play("attack-2")
		else:
			sprite.play("attack-1")
			animator.play("attack-1")
			
		
func flip(newDirection: String):
	direction=newDirection
	if(direction=="left"):
		sprite.flip_h=true
		shadow.flip_h=true
		$HitboxController.scale.x=-1
	else:
		sprite.flip_h=false
		shadow.flip_h=false
		$HitboxController.scale.x=1


func _on_player_animation_finished() -> void:
	if("attack" in sprite.animation):
		attacking=false
		sprite.play("idle")


func _enemy_hit(area: Area2D) -> void:
	area.get_parent().damage(damage)
	
func hit(newDamage):
	if(dead):
		return
	health-=newDamage
	hitAnimator.play("hit")
	GameManager.playerHealth=health
	if(health<=0):
		dead=true
		sprite.play("die")
		shadow.play("die")
		await get_tree().create_timer(1.5).timeout
		hitAnimator.play("die")
		await get_tree().create_timer(5).timeout
		get_tree().change_scene_to_file("res://Scenes/dead.tscn")
		
	
