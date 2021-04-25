extends Enemy

export (PackedScene) var Explosion
export (PackedScene) var DestructonBullet

var Game

func _ready():
	health_set(4.0)
	Game = get_node("..")

func destroy():
	var explosion = Explosion.instance()
	print(Explosion)
	print(explosion)
	Game.add_child(explosion)
	explosion.position = position
	spawn_bullets()
	.destroy()

func spawn_bullets():
	spawn_bullet(Vector2(0, 1))
	spawn_bullet(Vector2(1, 1))
	spawn_bullet(Vector2(1, 0))
	spawn_bullet(Vector2(1, -1))
	spawn_bullet(Vector2(0, -1))
	spawn_bullet(Vector2(-1, -1))
	spawn_bullet(Vector2(-1, 0))
	spawn_bullet(Vector2(-1, 1))

func spawn_bullet(direction):
	var bullet = DestructonBullet.instance()
	Game.call_deferred("add_child",bullet)
	bullet.position = position
	bullet.linear_velocity = direction.normalized() * 300
	bullet.set_player(get_node("../Player"))
