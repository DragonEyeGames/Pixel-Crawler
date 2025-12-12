extends Node

var player: Player
var playerHealth=20
var playerMaxHealth=20
var playerSpeed=12
var playerStrength=20
var transition: AnimationPlayer
var playerPos = null

enum playerTypes {
	Knight,
	Wizard,
	Axeman,
	Archer
}

var playerType:=playerTypes.Axeman

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Escape")):
		get_tree().quit()
