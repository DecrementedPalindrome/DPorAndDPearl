extends Enemy

export (PackedScene) var Explosion

func _ready():
	health_set(2.0)
	worth_set(1)

func _process(delta):
	look_at(Player.position)
	move_local_x(240*delta)

func destroy():
	var explosion = Explosion.instance()
	var Game = get_node("..")
	Game.add_child(explosion)
	explosion.position = position
	.destroy()
	
