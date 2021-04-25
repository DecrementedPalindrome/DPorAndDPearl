extends Enemy

export (PackedScene) var Explosion
export (PackedScene) var DestructonBullet

var Game

func _ready():
	health_set(4.0)
	worth_set(2)
	Game = get_node("..")

func _process(delta):
	look_at(Player.position)
	move_local_x(1)

func destroy():
	var explosion = Explosion.instance()
	Game.add_child(explosion)
	explosion.position = position
	spawn_bullets()
	.destroy()

func spawn_bullets():
	var forward_vector = Player.position-position
	spawn_bullet(forward_vector)
	spawn_bullet(forward_vector.rotated(0.2))
	spawn_bullet(forward_vector.rotated(-0.2))

func spawn_bullet(direction):
	var bullet = DestructonBullet.instance()
	Game.call_deferred("add_child",bullet)
	bullet.position = position
	bullet.linear_velocity = direction.normalized() * 300
	bullet.set_player(get_node("../Player"))
