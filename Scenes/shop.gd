extends Control

var playerGold

var itemList = []
var selectedList = []

func _ready() -> void:
	randomize()
	for child in $Paid.get_children():
		itemList.append(child)
		child.visible=false
	for i in range(0, 3):
		var newItem=itemList.pick_random()
		selectedList.append(newItem)
		itemList.erase(newItem)
		newItem.visible=true
	selectedList.shuffle()
	for item in selectedList:
		var itemParent=item.get_parent()
		itemParent.remove_child(item)
		itemParent.add_child(item)
	GameManager.playerGold=90
	playerGold=GameManager.playerGold
	calculateDisabled()

func Tome() -> void:
	playerGold-=25
	GameManager.playerGold-=25
	calculateDisabled()
	$Paid/Tome/Select.disabled=true
	$Paid/Tome/Select.text="Sold Out"
	GameManager.playerInventory.append(GameManager.inventoryItems.Tome)
	var backup=GameManager.playerMaxHealth
	GameManager.playerMaxHealth=round(GameManager.playerMaxHealth*1.2)
	GameManager.playerHealth+=GameManager.playerMaxHealth-backup


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
	GameManager.playerStrength*=1.25
	GameManager.playerStrength=round(GameManager.playerStrength)
	
func calculateDisabled():
	$"Gold Counter".text="Your Gold: " + str(playerGold)
	if(playerGold<30):
		$Paid/Ring/Select.disabled=true
	if(playerGold<40):
		$Paid/Chest/Select.disabled=true
	if(playerGold<25):
		$Paid/Tome/Select.disabled=true
	if(playerGold<35):
		$Paid/Eye/Select.disabled=true
	if(playerGold<50):
		$Paid/Armour/Select.disabled=true
	if(playerGold<15):
		$Paid/Tunic/Select.disabled=true
	if(playerGold<20):
		$Paid/Potion/Select.disabled=true


func Eye() -> void:
	playerGold-=35
	GameManager.playerGold=playerGold
	calculateDisabled()
	$Paid/Eye/Select.disabled=true
	$Paid/Eye/Select.text = "Sold Out"
	GameManager.playerInventory.append(GameManager.inventoryItems.Eye)
	GameManager.playerSpeed*=1.2
	GameManager.playerSpeed=round(GameManager.playerSpeed)


func Armour() -> void:
	playerGold-=50
	GameManager.playerGold=playerGold
	calculateDisabled()
	$Paid/Armour/Select.disabled=true
	$Paid/Armour/Select.text="Sold Out"
	GameManager.playerInventory.append(GameManager.inventoryItems.Armour)


func Tunic() -> void:
	playerGold-=15
	GameManager.playerGold=playerGold
	calculateDisabled()
	$Paid/Tunic/Select.disabled=true
	$Paid/Tunic/Select.text="Sold Out"
	GameManager.playerInventory.append(GameManager.inventoryItems.Armour)


func _on_continue_pressed() -> void:
	var data = SceneData.new()
	GameManager.playerPos=null
	if ResourceLoader.exists("user://scene_data.tres"):
		var oldData = ResourceLoader.load("user://scene_data.tres") as SceneData
		data.enemyArray=oldData.enemyArray
	data.playerPosition=null
	data.playerMaxHealth=GameManager.playerMaxHealth
	data.playerSpeed=GameManager.playerSpeed
	data.playerStrength=GameManager.playerStrength
	data.playerScene="res://Levels/Level" + str(2) + "/Level" + str(0) +".tscn"
	data.savedArray=GameManager.save
	data.playerType=GameManager.playerType
	data.playerGold=GameManager.playerGold
	data.playerInventory=GameManager.playerInventory.duplicate()
	ResourceSaver.save(data, "user://scene_data.tres")
	get_tree().change_scene_to_file("res://Levels/Level" + str(2) + "/Level" + str(0) +".tscn")


func Elixir() -> void:
	playerGold-=20
	GameManager.playerGold=playerGold
	calculateDisabled()
	$Paid/Potion/Select.disabled=true
	$Paid/Potion/Select.text = "Sold Out"
	GameManager.playerInventory.append(GameManager.inventoryItems.Elixir)
	GameManager.playerSpeed*=1.1
	GameManager.playerSpeed=round(GameManager.playerSpeed)
	GameManager.playerHealth*=1.1
	GameManager.playerHealth=round(GameManager.playerHealth)
	var backup=GameManager.playerMaxHealth
	GameManager.playerMaxHealth=round(GameManager.playerMaxHealth*1.1)
	GameManager.playerHealth+=GameManager.playerMaxHealth-backup
