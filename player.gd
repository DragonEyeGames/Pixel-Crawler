@icon("res://IconGodotNode/node_2D/icon_character.png")
extends CharacterBody2D

var sprite: AnimatedSprite2D
var shadow: AnimatedSprite2D
@export var speed := 100.0
var attacking:=false
var direction:="right"


func  _ready() -> void:
	sprite=$Player
	shadow=$Shadow
	
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
		
func flip(newDirection: String):
	direction=newDirection
	if(direction=="left"):
		sprite.flip_h=true
		shadow.flip_h=true
	else:
		sprite.flip_h=false
		shadow.flip_h=false
