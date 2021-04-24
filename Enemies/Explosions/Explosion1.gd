extends Node2D

func _process(delta):
	if $Sound.playing == false:
		queue_free()
