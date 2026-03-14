extends Node2D

var active=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Walls.collision_enabled=!active
	$Walls.visible=!active
	$Frame.visible=active
