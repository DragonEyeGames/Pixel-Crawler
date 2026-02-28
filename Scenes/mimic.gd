@icon("res://Assets/GodotIcon/icon_dice.png")
extends CharacterBody2D

var collided=false
var opened=false
var canMove=false
var sprite
var health:=5
var dead:=false
var colliding:=false
var player
var attacking:=false
var canAttack:=true
var animationFrame=0
@export var weaponDamage:=2.5
@export var cooldown:=.5
@onready var navAgent := $NavigationAgent2D as NavigationAgent2D
@export var speed=50
var hit:AnimationPlayer
@export var chest: PackedScene
var knockBack: Vector2

func _ready():
	$Timer.start()
	hit=$Hit
	sprite=$Sprite
	peek()
	if(not (sprite.animation=="peek" or sprite.animation=="idle")):
		opened=true
		canMove=true
		sprite.play("hopFront")
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		

func _process(_delta: float) -> void:
	if("hop" in sprite.animation):
		if(sprite.frame==1 and animationFrame!=1):
			$Land.pitch_scale=randf_range(.9, 1.1)
			$Land.play()
			animationFrame=1
		if(sprite.frame!=1):
			animationFrame=sprite.frame
	if(!dead):
		velocity=knockBack
		knockBack*=.65
		move_and_slide()
	player=GameManager.player
	if(attacking):
		return
	if(canAttack and colliding and opened):
		attacking=true
		canAttack=false
		$Chomp.pitch_scale=randf_range(.9, 1.1)
		$Chomp.play()
		if(sprite.animation=="hopFront"):
			sprite.play("attackFront")
		else:
			sprite.play("attackBack")
		$Hitbox/CollisionShape2D.set_deferred("disabled", false)
	if(collided and not opened and Input.is_action_just_pressed("Interact") and not opened):
		opened=true
		canAttack=false
		sprite.play("jumpscare")
		$Chomp.play()
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		await get_tree().create_timer(1).timeout
		canAttack=true
	if(canMove):
		velocity=Vector2.ZERO
		if(global_position.distance_to(GameManager.player.global_position)>=20):
			var dir = to_local(navAgent.get_next_path_position()).normalized()
			velocity = dir*speed
			#velocity=player.global_position-global_position
			#velocity=velocity.normalized()*speed
		move_and_slide()
		if(velocity.x<0):
			sprite.flip_h=false
		elif(velocity.x>0):
			sprite.flip_h=true
		if(velocity.y<0 and sprite.animation=="hopFront"):
			sprite.play("hopBack")
		elif(velocity.y>0 and sprite.animation=="hopBack"):
			sprite.play("hopFront")

func peek():
	await get_tree().create_timer(randf_range(5, 10)).timeout
	if(not opened):
		sprite.play("peek")
		peek()

func _on_area_2d_area_entered(_area: Area2D) -> void:
	collided=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	collided=false

func damage(hitDamage, hitGlobalPos):
	if(dead or not opened):
		return
	$Impact.pitch_scale=randf_range(.9, 1.1)
	$Impact.play()
	knockBack+=(global_position-hitGlobalPos).normalized()*500
	health-=hitDamage
	hit.play("hit")
	if(health<=0):
		dead=true
		opened=false
		$Chest.visible=true
		$Chest.active=true
		var globalPos=$Chest.global_position
		var newChest = $Chest
		call_deferred("remove_child", newChest)
		get_parent().call_deferred("add_child", newChest)
		newChest.global_position=globalPos
		SignalBus.enemy_died.emit()
		sprite.play("boom")

func _on_animation_finished() -> void:
	if(sprite.animation=="peek"):
		sprite.play("idle")
	elif(sprite.animation=="jumpscare"):
		sprite.play("hopFront")
		canMove=true
	elif("attack" in sprite.animation):
		attacking=false
		$Hitbox/CollisionShape2D.set_deferred("disabled", true)
		if(sprite.animation=="attackBack"):
			sprite.play("hopBack")
		else:
			sprite.play("hopFront")
		await get_tree().create_timer(cooldown).timeout
		canAttack=true
	elif(sprite.animation=="boom"):
		queue_free()

func makePath():
	navAgent.target_position = player.global_position
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


func _on_attack_check_area_entered(_area: Area2D) -> void:
	colliding=true


func _on_attack_check_area_exited(_area: Area2D) -> void:
	colliding=false


func _on_hitbox_area_entered(area: Area2D) -> void:
	if(not dead):
		area.get_parent().hit(weaponDamage)
