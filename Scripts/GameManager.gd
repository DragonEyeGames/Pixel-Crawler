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

# Volumes 'n Stuff
var musicVolume = 0
var sfxVolume = 0
var masterVolume = 0

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
