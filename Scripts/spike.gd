@icon("res://Assets/GodotIcon/icon_event.png")
extends AnimatedSprite2D
@export var damage:=1

func _process(_delta: float) -> void:
	if(animation=="extrude" and $Hitzone/CollisionShape2D.disabled==true):
		$Hitzone/CollisionShape2D.set_deferred("disabled", false)
	if(animation=="down" and $Hitzone/CollisionShape2D.disabled==false):
		$Hitzone/CollisionShape2D.set_deferred("disabled", true)

func _on_hitzone_area_entered(area: Area2D) -> void:
	area.get_parent().hit(damage)


func _on_animation_finished() -> void:
	if(animation=="extrude"):
		play("up")
	else:
		play("down")
		
func extrude():
	play("extrude")
	$Extrude.pitch_scale=randf_range(.95, 1.05)
	$Extrude.play()
	
func retract():
	play("retract")
	$Retract.pitch_scale=randf_range(.95, 1.05)
	$Retract.play()
