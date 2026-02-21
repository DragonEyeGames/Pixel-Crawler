extends Node2D

@export var levels: Array[PackedScene]
@export var caps: Array[PackedScene]
var instantiatedLevels=[]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for level in levels:
		var newLevel = level.instantiate()
		#add_child(newLevel)
		newLevel.visible=false
		instantiatedLevels.append(newLevel)
	var level = null
	while level==null:
		var testLevel = instantiatedLevels.pick_random()
		if(testLevel.is_in_group("North")):
			level=testLevel
	add_child(level)
	var door = null
	while door==null:
		var testDoor=level.doors.pick_random()
		if(testDoor.direction=="north"):
			door=testDoor
	print(door.direction)
	if(door.direction=="north"):
		var levelReplacement=null
		while levelReplacement==null:
			var testLevel = instantiatedLevels.pick_random()
			if(testLevel.is_in_group("South") and testLevel!=level):
				levelReplacement=testLevel
		add_child(levelReplacement)
		var newDoor=null
		while newDoor==null:
			var testDoor=levelReplacement.doors.pick_random()
			if(testDoor.direction=="south"):
				newDoor=testDoor
		var offset=levelReplacement.global_position-newDoor.global_position
		levelReplacement.visible=true
		level.visible=true
		#newDoor.global_position=door.global_position
		#levelReplacement.global_position=newDoor.global_position+offset
		levelReplacement.global_position = door.global_position - newDoor.global_position
		newDoor.queue_free()
		door.queue_free()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
