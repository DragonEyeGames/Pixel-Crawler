extends CanvasLayer

var goldValue:=0
var goldCount:=0.0
var goldOffset=0

var goldMultiplier=true

func _ready() -> void:
	visible=true
	GameManager.transition=$Transition/AnimationPlayer
	$Gold.text=str(GameManager.playerGold)
	goldValue=GameManager.playerGold

func _process(delta: float) -> void:
	$ProgressBar.max_value=GameManager.playerMaxHealth
	$ProgressBar.value=GameManager.playerHealth
	goldOffset+=GameManager.playerGold-goldValue-goldOffset
	if(goldOffset==0):
		await get_tree().create_timer(3).timeout
		goldMultiplier=true
	if(GameManager.playerGold!=goldValue):
		if(goldMultiplier and GameManager.inventoryItems.Chest in GameManager.playerInventory):
			GameManager.playerGold+=goldOffset
			goldMultiplier=false
		goldCount+=delta*10
		if(goldCount>1):
			goldCount-=1
			goldValue+=1
			$Gold.text=str(goldValue)
