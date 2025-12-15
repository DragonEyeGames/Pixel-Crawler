@icon("res://Assets/GodotIcon/icon_dice.png")
extends CharacterBody2D

var collided=false
var opened=false
var canMove=false
var sprite
@onready var navAgent := $NavigationAgent2D as NavigationAgent2D
@export var speed=50

func _ready():
	sprite=$Sprite
	peek()

func _process(_delta: float) -> void:
	if(collided and not opened and Input.is_action_just_pressed("Interact") and not opened):
		opened=true
		sprite.play("jumpscare")
	if(canMove):
		velocity=Vector2.ZERO
		if(global_position.distance_to(GameManager.player.global_position)>=20):
			var dir = to_local(navAgent.get_next_path_position()).normalized()
			velocity = dir*speed
			#velocity=player.global_position-global_position
			#velocity=velocity.normalized()*speed
		move_and_slide()

func peek():
	await get_tree().create_timer(randf_range(5, 10)).timeout
	if(not opened):
		sprite.play("peek")
		peek()

func _on_area_2d_area_entered(_area: Area2D) -> void:
	collided=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	collided=false


func _on_animation_finished() -> void:
	if(sprite.animation=="peek"):
		sprite.play("idle")
	if(sprite.animation=="jumpscare"):
		sprite.play("hopFront")
		canMove=true

func makePath():
	navAgent.target_position = GameManager.player.global_position
	await navAgent.path_changed
	
	var points = navAgent.get_current_navigation_path()
	var length = 0.0

	for i in range(points.size() - 1):
		length += points[i].distance_to(points[i + 1])

	if length > 150:
		# Too long — cancel the move
		navAgent.target_position = global_position 
		return

func _on_timer_timeout() -> void:
	makePath()
