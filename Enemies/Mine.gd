extends Enemy

export (PackedScene) var Explosion

func _ready():
	health_set(2.0)

func destroy():
	var explosion = Explosion.instance()
	var Game = get_node("..")
	Game.add_child(explosion)
	explosion.position = position
	.destroy()
