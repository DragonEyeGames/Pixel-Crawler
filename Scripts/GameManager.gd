extends Node

var player: Player
var playerHealth=20
var playerMaxHealth=20
var transition: AnimationPlayer
var playerPos = null

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Escape")):
		get_tree().quit()
