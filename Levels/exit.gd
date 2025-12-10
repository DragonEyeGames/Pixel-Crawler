extends Sprite2D

var colliding:=false

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Interact") and colliding):
		GameManager.player.canMove=false
		var tween=create_tween()
		tween.tween_property(GameManager.player, "global_position", $StaticBody2D/CollisionPolygon2D.global_position, .1)

func _on_area_2d_area_entered(_area: Area2D) -> void:
	colliding=true


func _on_area_2d_area_exited(area: Area2D) -> void:
	colliding=false
