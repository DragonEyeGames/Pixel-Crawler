@icon("res://Assets/GodotIcon/icon_character.png")
extends Player
class_name Archer

@export var arrowScene: PackedScene

var charged:=false
	
func _physics_process(_delta: float) -> void:
	if(sprite==null):
		queue_free()
		return
	if(dead or not canMove):
		return
	if(attacking):
		if(Input.is_action_just_released("Attack") and attacking):
			if(charged):
				if("1" in sprite.animation):
					sprite.play("launch-1")
				else:
					sprite.play("launch-2")
				spawnArrow()
			else:
				attacking=false
				sprite.speed_scale=1.0
				animator.speed_scale=1.0
				sprite.play("idle")
			charged=false
			
		else:
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
		charged=false
		sprite.speed_scale=attackSpeed
		animator.speed_scale=attackSpeed
		if(randi_range(1, 10)==10):
			sprite.play("charge-2")
		else:
			sprite.play("charge-1")
			
func spawnArrow():
	var arrow=arrowScene.instantiate()
	get_parent().add_child(arrow)
	var newDirection:=1
	if(sprite.flip_h):
		newDirection=-1
	arrow.global_position=global_position+Vector2(21*newDirection, 0)
	arrow.weaponDamage=damage*strength
	arrow.initialVelocity=Vector2(1*newDirection, 0).normalized()
	arrow.playerFired=true
	arrow.speed=speed*4
	
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
	if("launch" in sprite.animation):
		attacking=false
		charged=false
		sprite.speed_scale=1.0
		animator.speed_scale=1.0
		sprite.play("idle")
	elif("charge" in sprite.animation):
		charged=true


func _enemy_hit(area: Area2D) -> void:
	area.get_parent().damage(damage*strength)
		
	
