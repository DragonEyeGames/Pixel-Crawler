extends CharacterBody2D

var initialVelocity=Vector2.ZERO
var weaponDamage = 2

func _ready():
	await get_tree().process_frame
	initialVelocity=initialVelocity.normalized()
	if(initialVelocity.x<0):
		scale.x=-1
	
func _physics_process(_delta: float) -> void:
	velocity=initialVelocity*250
	move_and_slide()
	if(is_on_wall() or is_on_ceiling() or is_on_floor()):
		queue_free()


func _on_hits_area_entered(area: Area2D) -> void:
	area.get_parent().hit(weaponDamage)
