extends Sprite2D

var dead:=false

func damage(_hitDamage, _hitPos):
	if(dead):
		return
	dead=true
	$CPUParticles2D.emitting=true
	$Shatter.pitch_scale=randf_range(.9, 1.1)
	$Shatter.play()
	self_modulate.a=0
	await get_tree().create_timer(.5).timeout
	queue_free()
