extends Node

var save:=[]

var player: Player
var playerHealth:=20.0
var playerMaxHealth:=20.0
var playerSpeed:=12.0
var playerStrength:=20.0
var transition: AnimationPlayer
var playerPos = null
var playerGold:=0

enum inventoryItems {
	Tome,
	Ring,
	Chest,
	Eye,
	Tunic,
	Armour,
	Elixir
}

var playerInventory = []

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
