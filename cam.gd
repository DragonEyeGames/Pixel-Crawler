extends Camera2D

var shaking=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Engine.time_scale != 1.0 and not shaking and not GameManager.player.dead):
		shaking=true
		shake()
		
func shake():
	position_smoothing_enabled=false
	for i in 10:
		var amount=2
		position=Vector2(randi_range(-amount, amount), randi_range(-amount, amount))
		await get_tree().process_frame
	position_smoothing_enabled=true
	position=Vector2.ZERO
	shaking=false
