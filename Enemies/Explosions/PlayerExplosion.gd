extends Node2D

func _ready():
	$ParticleCloud.emitting = true

func _process(delta):
	if $Sound.playing == false:
		queue_free()
