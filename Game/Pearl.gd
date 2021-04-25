extends Sprite

export (PackedScene) var PlayerBullet

signal win(time)

var Player
var Game

var win_time = 0
var last_bullet_wave_time = 0

func _ready():
	position = Global.pearl_location
	Player = get_node("../Player")
	Game = get_node("..")

func _process(delta):
	if Player.position.distance_to(position) < 80 && win_time == 0:
		Player.damage_timer = 100
		win_time = OS.get_ticks_msec()
		emit_signal("win", win_time)
	if win_time != 0 && OS.get_ticks_msec() > last_bullet_wave_time + 500:
		spawn_bullet_wave()
		last_bullet_wave_time = OS.get_ticks_msec()

func spawn_bullet_wave():
	for i in range(50):
		var bullet = PlayerBullet.instance()
		Game.call_deferred("add_child",bullet)
		bullet.position = position
		bullet.linear_velocity = Vector2(-400, 0).rotated(PI/49 * i)
		bullet.set_player(self)
