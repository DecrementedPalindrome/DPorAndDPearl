extends Enemy

export (PackedScene) var Explosion
export (PackedScene) var DestructonBullet

var Game

func _ready():
	health_set(3.0)
	worth_set(2)
	Game = get_node("..")

func _physics_process(delta):
	position.y += sin((position.x/2 + OS.get_ticks_msec()) / 1000) * delta * 10

func destroy():
	var explosion = Explosion.instance()
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
