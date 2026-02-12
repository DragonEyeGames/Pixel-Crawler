@icon("res://Assets/GodotIcon/icon_character.png")
extends Player
class_name Axeman

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
		sprite.speed_scale=attackSpeed
		animator.speed_scale=attackSpeed
		sprite.play("attack-1")
		animator.play("attack-1")
	if(Input.is_action_just_pressed("Attack-2") and attacking==false):
		attacking=true
		sprite.speed_scale=attackSpeed
		animator.speed_scale=attackSpeed
		sprite.play("attack-2")
		animator.play("attack-2")
		
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
	if("attack-1" == sprite.animation):
		attacking=false
		sprite.speed_scale=1.0
		animator.speed_scale=1.0
		sprite.play("idle")
	if("attack-2" == sprite.animation):
		sprite.speed_scale=1.0
		animator.speed_scale=1.0
		sprite.play("idle")
		await get_tree().create_timer(.4).timeout
		attacking=false


func _enemy_hit(area: Area2D) -> void:
	area.get_parent().damage(damage*strength)
		
	
