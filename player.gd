@icon("res://IconGodotNode/node_2D/icon_character.png")
extends CharacterBody2D

var sprite: AnimatedSprite2D
var shadow: AnimatedSprite2D
@export var speed := 100.0
@export var damage=1
var attacking:=false
var direction:="right"
var animator:AnimationPlayer


func  _ready() -> void:
	sprite=$Player
	shadow=$Shadow
	animator=$Attack
	
func _physics_process(_delta: float) -> void:
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
