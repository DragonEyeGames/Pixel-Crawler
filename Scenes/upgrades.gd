extends Control

enum selectedTypes {Damage, Speed, Health}
var selected:selectedTypes

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
