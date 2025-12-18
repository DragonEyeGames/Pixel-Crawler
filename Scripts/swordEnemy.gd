@icon("res://Assets/GodotIcon/icon_sword.png")
extends CharacterBody2D

@export var health:=5.0
var hit:AnimationPlayer
var sprite:AnimatedSprite2D
var shadow: AnimatedSprite2D
var dead=false
var player: CharacterBody2D
@export var speed = 100
var direction:="right"
var attacking:=false
var animator: AnimationPlayer
var attackingList:=[]
var canAttack:=true
@export var cooldown:=.25
@export var weaponDamage:=1
@onready var navAgent := $NavigationAgent2D as NavigationAgent2D
var maxHealth

func _ready() -> void:
	maxHealth=health
	await get_tree().process_frame
	$Timer.start()
	hit=$Hit
	sprite=$Sprite
	shadow=$Shadow
	player=GameManager.player
	animator = $Attack
	cooldown*=1.5

func _physics_process(_delta: float) -> void:
	if(player==null):
		player=GameManager.player
		return
	player=GameManager.player
	if(dead and not sprite.animation=="die"):
		sprite.play("die")
		shadow.play("die")
	if(dead or attacking):
		return
	if(len(attackingList)>=1 and canAttack):
		if player.dead!=true:
			attack()
			return
	velocity=Vector2.ZERO
	if(global_position.distance_to(player.global_position)>=20):
		var dir = to_local(navAgent.get_next_path_position()).normalized()
		velocity = dir*speed
		#velocity=player.global_position-global_position
		#velocity=velocity.normalized()*speed
	move_and_slide()
	if(velocity!=Vector2.ZERO and sprite.animation=="idle"):
		sprite.play("walk")
	if(velocity==Vector2.ZERO and sprite.animation=="walk"):
		sprite.play("idle")
	if(velocity.x<-1):
		flip("left")
	elif(velocity.x>1):
		flip("right")

func flip(newDirection):
	direction=newDirection
	if(direction=="left"):
		sprite.flip_h=true
		shadow.flip_h=true
		$Areas.scale.x=-1
	else:
		sprite.flip_h=false
		shadow.flip_h=false
		$Areas.scale.x=1

func damage(hitDamage):
	if(dead):
		return
	health-=hitDamage
	hit.play("hit")
	if(health<=0):
		dead=true
		if(not sprite.animation=="die"):
			sprite.play("die")
			shadow.play("die")
		await get_tree().create_timer(1.5).timeout
		hit.play("die")
		GameManager.playerGold+=randi_range(maxHealth-1, maxHealth+1)
		SignalBus.enemy_died.emit()
		await get_tree().create_timer(5).timeout
		await get_tree().process_frame
		queue_free()

func attack():
	if(attacking or dead):
		return
	attacking=true
	canAttack=false
	sprite.play("idle")
	await get_tree().create_timer(cooldown/2).timeout
	if(randi_range(1, 2)==2):
		sprite.play("attack-2")
		animator.play("attack-2")
	else:
		sprite.play("attack-1")
		animator.play("attack-1")

func _on_checks_area_entered(area: Area2D) -> void:
	attackingList.append(area.get_parent())


func _on_sprite_animation_finished() -> void:
	if("attack" in sprite.animation):
		attacking=false
		sprite.play("idle")
		await get_tree().create_timer(cooldown/2).timeout
		canAttack=true


func _on_checks_area_exited(area: Area2D) -> void:
	attackingList.erase(area.get_parent())


func _on_hits_area_entered(area: Area2D) -> void:
	if(not dead):
		area.get_parent().hit(weaponDamage)

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
