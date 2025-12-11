extends Sprite2D

var dead:=false

func damage(_hitDamage):
	if(dead):
		return
	dead=true
	$CPUParticles2D.emitting=true
	self_modulate.a=0
	await get_tree().create_timer(.5).timeout
	queue_free()
