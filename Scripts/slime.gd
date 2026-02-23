@icon("res://Assets/GodotIcon/icon_sword.png")
extends CharacterBody2D

@export var health:=5.0
var hit:AnimationPlayer
@onready var sprite:AnimatedSprite2D = $Sprite
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

func _ready() -> void:
	hit=$Hit
	sprite=$Sprite
	shadow=$Shadow
	player=GameManager.player
	animator = $Attack
	await get_tree().process_frame
	hit=$Hit
	sprite=$Sprite
	shadow=$Shadow
	player=GameManager.player
	animator = $Attack

func _physics_process(_delta: float) -> void:
	if(player==null):
		player=GameManager.player
		return
	player=GameManager.player
	if(dead or attacking):
		return
	if(len(attackingList)>=1 and canAttack):
		if player.dead!=true:
			attack()
			return
	velocity=Vector2.ZERO
	if(global_position.distance_to(player.global_position)>=30):
		velocity=player.global_position-global_position
		velocity=velocity.normalized()*speed
	elif(canAttack):
		attack()
	move_and_slide()
	if(velocity!=Vector2.ZERO and sprite.animation=="idle"):
		sprite.play("walk")
		shadow.play("walk")
	if(velocity==Vector2.ZERO and sprite.animation=="walk"):
		sprite.play("idle")
	elif velocity==Vector2.ZERO:
		shadow.play("default")
	if(velocity.x<0):
		flip("left")
	elif(velocity.x>0):
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
		sprite.play("die")
		shadow.play("default")
		await get_tree().create_timer(1.5).timeout
		hit.play("die")
		SignalBus.enemy_died.emit()
		await get_tree().create_timer(5).timeout
		await get_tree().process_frame
		queue_free()

func attack():
	if(attacking or dead):
		return
	attacking=true
	canAttack=false
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
		await get_tree().create_timer(cooldown).timeout
		canAttack=true


func _on_checks_area_exited(area: Area2D) -> void:
	attackingList.erase(area.get_parent())


func _on_hits_area_entered(area: Area2D) -> void:
	if(not dead):
		area.get_parent().hit(weaponDamage)
