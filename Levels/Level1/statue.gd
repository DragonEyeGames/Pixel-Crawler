extends Area2D


var colliding=false
var used:=false

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Interact") and colliding and not used):
		GameManager.playerHealth=GameManager.player.health
		GameManager.playerHealth+=10
		if(GameManager.playerHealth>GameManager.playerMaxHealth):
			GameManager.playerHealth=GameManager.playerMaxHealth
		GameManager.player.health=GameManager.playerHealth
		used=true
		colliding=false
		$Used.visible=true

func _on_area_entered(_area: Area2D) -> void:
	colliding=true


func _on_area_exited(_area: Area2D) -> void:
	colliding=false
