extends Node2D

export (NodePath) var game_path
export (NodePath) var player_path
export (PackedScene) var Mine
export (PackedScene) var ExplosiveMine
export (PackedScene) var Torpedo

var Game
var Player

func _ready():
	randomize()
	Game = get_node(game_path)
	Player = get_node(player_path)
	


func spawn_wave():
	var player_position = Player.position
	spawn_mines(player_position)
	spawn_torpedoes(player_position)

func spawn_mines(var player_position):
	for i in range(clamp(1000 -player_position.y / 10, 1, 10)):
		var mine = ExplosiveMine.instance()
		Game.call_deferred("add_child",mine)
		mine.set_player(Player)
		var direction = randi()%4
		match direction:
			0:
				mine.position = player_position + Vector2(rand_range(-700, 700), rand_range(-400, -700))
			1:
				mine.position = player_position + Vector2(rand_range(700, 1000), rand_range(-400, 400))
			2:
				mine.position = player_position + Vector2(rand_range(-700, 700), rand_range(400, 700))
			3:
				mine.position = player_position + Vector2(rand_range(-700, -1000), rand_range(-400, 400))
		if mine.position.y <= 50 || mine.position.y >= Global.ocean_depth - 50:
			mine.queue_free()

func spawn_torpedoes(var player_position):
	#Increase in frequency over time up to max at 30 seconds
	for i in range(int(rand_range(0, 1.5) + clamp(OS.get_ticks_msec() / 20000, 0, 1.5))):
		var torpedo = Torpedo.instance()
		Game.call_deferred("add_child",torpedo)
		torpedo.set_player(Player)
		var direction = randi()%4
		match direction:
			0:
				torpedo.position = player_position + Vector2(rand_range(-700, 700), rand_range(-400, -700))
			1:
				torpedo.position = player_position + Vector2(rand_range(700, 1000), rand_range(-400, 400))
			2:
				torpedo.position = player_position + Vector2(rand_range(-700, 700), rand_range(400, 700))
			3:
				torpedo.position = player_position + Vector2(rand_range(-700, -1000), rand_range(-400, 400))
		if torpedo.position.y <= 50 || torpedo.position.y >= Global.ocean_depth - 50:
			torpedo.queue_free()


func _on_WaveTimer_timeout():
	spawn_wave()
