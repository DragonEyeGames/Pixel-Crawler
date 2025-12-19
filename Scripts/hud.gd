extends CanvasLayer

var goldValue:=0
var goldCount:=0.0

func _ready() -> void:
	GameManager.transition=$Transition/AnimationPlayer
	$Gold.text=str(GameManager.playerGold)
	goldValue=GameManager.playerGold

func _process(delta: float) -> void:
	$ProgressBar.max_value=GameManager.playerMaxHealth
	$ProgressBar.value=GameManager.playerHealth
	if(GameManager.playerGold!=goldValue):
		goldCount+=delta*10
		if(goldCount>1):
			goldCount-=1
			goldValue+=1
			$Gold.text=str(goldValue)
