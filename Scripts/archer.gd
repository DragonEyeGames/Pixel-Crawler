@icon("res://Assets/GodotIcon/icon_sword.png")
extends CharacterBody2D

@export var health:=5
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
@export var startDirection:="left"
@export var arrowScene: PackedScene

func _ready() -> void:
	hit=$Hit
	sprite=$Sprite
	shadow=$Shadow
	player=GameManager.player
	animator = $Attack
	if(startDirection!=direction):
		flip(startDirection)

func _physics_process(_delta: float) -> void:
	if(dead or attacking):
		return
	if(len(attackingList)>=1 and canAttack):
		if player.dead!=true:
			attack()
			return
	velocity=Vector2.ZERO
	velocity=-global_position+GameManager.player.global_position
	velocity=velocity.normalized()*speed
	velocity.x=0
	print(velocity)
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
		sprite.play("die")
		shadow.play("die")
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
	sprite.play("attack-1")
	animator.play("attack-1")
	var arrow = arrowScene.instantiate()
	get_parent().add_child(arrow)
	var offset = Vector2(11, 0)
	if(direction=="left"):
		offset.x*=-1
	arrow.global_position=global_position + offset
	arrow.initialVelocity=-global_position+GameManager.player.global_position
	

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
