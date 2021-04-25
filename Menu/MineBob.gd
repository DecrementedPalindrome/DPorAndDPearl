extends Sprite

func _physics_process(delta):
	position.y += sin((position.x*2 + OS.get_ticks_msec()) / 1000) * delta * 10
