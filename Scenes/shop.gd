extends Control

var playerGold

func _ready() -> void:
	GameManager.playerGold=100
	playerGold=GameManager.playerGold
	calculateDisabled()

func Tome() -> void:
	playerGold-=25
	GameManager.playerGold-=25
	calculateDisabled()
	$Paid/Tome/Select.disabled=true
	$Paid/Tome/Select.text="Sold Out"
	GameManager.playerInventory.append(GameManager.inventoryItems.Tome)


func Chest() -> void:
	playerGold-=40
	GameManager.playerGold-=40
	calculateDisabled()
	$Paid/Chest/Select.disabled=true
	$Paid/Chest/Select.text="Sold Out"
	GameManager.playerInventory.append(GameManager.inventoryItems.Chest)

func Ring() -> void:
	playerGold-=30
	GameManager.playerGold-=playerGold
	calculateDisabled()
	$Paid/Ring/Select.disabled=true
	$Paid/Ring/Select.text="Sold Out"
	GameManager.playerInventory.append(GameManager.inventoryItems.Ring)
	
func calculateDisabled():
	$"Gold Counter".text="Your Gold: " + str(playerGold)
	if(playerGold<30):
		$Paid/Ring/Select.disabled=true
	if(playerGold<40):
		$Paid/Chest/Select.disabled=true
	if(playerGold<25):
		$Paid/Tome/Select.disabled=true
