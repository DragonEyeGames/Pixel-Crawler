extends Control

enum selectedTypes {Damage, Speed, Health}
var selected:selectedTypes

func _ready() -> void:
	$Control/VBoxContainer/Health.text="Health: " + str(int(GameManager.playerMaxHealth))
	$Control/VBoxContainer/Speed.text="Speed: " + str(int(GameManager.playerSpeed))
	$Control/VBoxContainer/Strength.text="Strength: " + str(int(GameManager.playerStrength))

func _damage() -> void:
	$Free/Damage.color = Color.DARK_GREEN
	match selected:
		selectedTypes.Speed:
			$Free/Speed.color = Color.BLACK
		selectedTypes.Health:
			$Free/Health.color = Color.BLACK
	selected=selectedTypes.Damage


func _speed() -> void:
	$Free/Speed.color = Color.DARK_GREEN
	match selected:
		selectedTypes.Damage:
			$Free/Damage.color = Color.BLACK
		selectedTypes.Health:
			$Free/Health.color = Color.BLACK
	selected=selectedTypes.Speed


func _health() -> void:
	$Free/Health.color = Color.DARK_GREEN
	match selected:
		selectedTypes.Speed:
			$Free/Speed.color = Color.BLACK
		selectedTypes.Damage:
			$Free/Damage.color = Color.BLACK
	selected=selectedTypes.Health


func _on_continue_pressed() -> void:
	match selected:
		selectedTypes.Health:
			GameManager.playerMaxhealth+=1
			GameManager.playerHealth+=1
		selectedTypes.Damage:
			GameManager.playerStrength+=1
		selectedTypes.Speed:
			GameManager.playerSpeed+=1
	get_tree().change_scene_to_file("res://Scenes/shop.tscn")
