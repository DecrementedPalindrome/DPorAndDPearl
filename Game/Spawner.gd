extends Node2D

export (NodePath) var game_path
export (NodePath) var player_path
export (PackedScene) var Mine
export (PackedScene) var ExplosiveMine
export (PackedScene) var Torpedo
export (PackedScene) var ExplosiveTorpedo

var Game
var Player

var starting_time

func _ready():
	randomize()
	Game = get_node(game_path)
	Player = get_node(player_path)
	starting_time = OS.get_ticks_msec()

func spawn_wave():
	var player_position = Player.position
	spawn_mines(player_position)
	spawn_explosive_mines(player_position)
	spawn_torpedoes(player_position)

func spawn_mines(var player_position):
	for i in range(clamp(1000 -player_position.y / 10, 1, 10)):
		var mine = Mine.instance()
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

func spawn_explosive_mines(var player_position):
	for i in range(clamp((player_position.y - 1000) / 400, 0, 10)):
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
	#Increase in frequency over time up to max at 45 seconds
	var spawn_amount = int(rand_range(0, 1.5) + clamp((OS.get_ticks_msec()-starting_time) / 30000, 0, 1.5))
	#From 20 seconds onwards increase the chance to spawn an explosive torpedo.
	#Guaranteed at 50 seconds
	var explosive_chance = clamp(((OS.get_ticks_msec()-starting_time) - 20000) / 30000.0, 0, 1)
	for i in range(spawn_amount):
		var torpedo
		if randf() < explosive_chance:
			torpedo = ExplosiveTorpedo.instance()
		else:
			torpedo = Torpedo.instance()
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
