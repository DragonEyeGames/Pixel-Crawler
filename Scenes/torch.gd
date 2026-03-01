extends AnimatedSprite2D

@export var multiplier = .3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.volume_db*=1.3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$PointLight2D.energy=$PointLight2D.texture_scale*multiplier
