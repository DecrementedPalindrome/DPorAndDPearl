extends Enemy

export (PackedScene) var Explosion

func _ready():
	health_set(2.0)
	worth_set(1)

func _physics_process(delta):
	position.y += sin((position.x/2 + OS.get_ticks_msec()) / 1000) * delta * 10

func destroy():
	var explosion = Explosion.instance()
	var Game = get_node("..")
	Game.add_child(explosion)
	explosion.position = position
	.destroy()
