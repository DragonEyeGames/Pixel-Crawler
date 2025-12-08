extends CanvasLayer

func _ready() -> void:
	GameManager.transition=$Transition/AnimationPlayer

func _process(_delta: float) -> void:
	$ProgressBar.max_value=GameManager.playerMaxHealth
	$ProgressBar.value=GameManager.playerHealth
