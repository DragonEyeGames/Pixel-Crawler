@icon("res://IconGodotNode/node_2D/icon_sword.png")
extends CharacterBody2D

var health:=5
var hit:AnimationPlayer
var sprite:AnimatedSprite2D
var dead=false

func _ready() -> void:
	hit=$AnimationPlayer
	sprite=$Sprite

func damage(hitDamage):
	if(dead):
		return
	health-=hitDamage
	hit.play("hit")
	if(health<=0):
		dead=true
		sprite.play("die")
