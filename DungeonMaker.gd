extends Node2D

@export var levels: Array[PackedScene]
@export var caps: Array[PackedScene]
@export var startingLevel: Node2D
var instantiatedLevels=[]
var placedLevels=[] #The levels that have already been moved and generated n stuff
var uniqueLeft=[]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for level in levels:
		var newLevel = level.instantiate()
		#add_child(newLevel)
		newLevel.visible=false
		uniqueLeft.append(newLevel)
		for door in newLevel.doors:
			instantiatedLevels.append(newLevel)
	generateWorld()
		

func generate(on: Node2D):
	var level = on
	while level==null:
		if(len(instantiatedLevels)<=0):
			return
		var testLevel = instantiatedLevels.pick_random()
		if(testLevel.is_in_group("North")):
			level=testLevel
			add_child(level)
			uniqueLeft.erase(level)
			instantiatedLevels.erase(level)
			placedLevels.append(level)
			level.visible=true
	var door = null
	var north_doors = []
	for d in level.doors:
		if d.direction == "north":
			north_doors.append(d)
	if north_doors.is_empty():
		#generate(placedLevels.pick_random())
		return
	door = north_doors.pick_random()
	level.doors.erase(door)
	print(door.direction)
	if(door.direction=="north"):
		var levelReplacement=null
		while levelReplacement==null:
			if(len(instantiatedLevels)<=0):
				return
			var testLevel = instantiatedLevels.pick_random()
			if(testLevel.is_in_group("South") and testLevel!=level and testLevel in uniqueLeft):
				levelReplacement=testLevel
				add_child(levelReplacement)
				instantiatedLevels.erase(levelReplacement)
				#placedLevels.append(levelReplacement)
		var newDoor=null
		var south_doors = []

		for d in levelReplacement.doors:
			if d.direction == "south":
				south_doors.append(d)

		if south_doors.is_empty():
			#generate(placedLevels.pick_random())
			return

		newDoor = south_doors.pick_random()
		levelReplacement.doors.erase(newDoor)
		levelReplacement.global_position = door.global_position - newDoor.position
		await get_tree().process_frame
		await get_tree().process_frame
		if(levelReplacement.colliding):
			print("Coldsd")
			level.colliding=false
			levelReplacement.colliding=false
			remove_child(levelReplacement)
			instantiatedLevels.append(levelReplacement)
			level.doors.append(door)
			levelReplacement.doors.append(newDoor)
			#placedLevels.erase(levelReplacement)
			#generate(placedLevels.pick_random())
		else:
			placedLevels.append(levelReplacement)
			uniqueLeft.erase(levelReplacement)
			door.connection=newDoor
			newDoor.connection=door
			

func generateWorld():
	await generate(startingLevel)
	await get_tree().physics_frame
	while len(uniqueLeft)>0:
		await generate(placedLevels.pick_random())
	await get_tree().process_frame
	SignalBus.generated.emit()
