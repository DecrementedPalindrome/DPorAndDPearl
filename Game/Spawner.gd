extends Node2D

export (NodePath) var game_path
export (NodePath) var player_path
export (PackedScene) var Mine
export (PackedScene) var ArrowMine
export (PackedScene) var ExplosiveMine
export (PackedScene) var Torpedo
export (PackedScene) var ExplosiveTorpedo
export (PackedScene) var FastTorpedo

var Game
var Player

var starting_time

var blocker_level = 0

func _ready():
	randomize()
	Game = get_node(game_path)
	Player = get_node(player_path)
	starting_time = OS.get_ticks_msec()

func spawn_wave():
	var player_position = Player.position
	spawn_mines(player_position)
	spawn_explosive_mines(player_position)
	spawn_torpedoes()
	if blocker_level == 0 && Player.position.y > 2000:
		spawn_mine_blocker(Mine)
		blocker_level = 1
	elif blocker_level == 1 && Player.position.y > 6000:
		spawn_mine_blocker(ExplosiveMine)
		blocker_level = 2

func spawn_mines(var player_position):
	for i in range(clamp(1000 -player_position.y / 10, 1, 10)):
		var mine
		if player_position.y > Global.ocean_depth - 600:
			mine = ArrowMine.instance()
		else:
			mine = Mine.instance()
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

func spawn_torpedoes():
	#Increase in frequency over time up to max at 45 seconds
	var spawn_amount = int(rand_range(0, 1.5) + clamp((OS.get_ticks_msec()-starting_time) / 30000, 0, 1.5))
	#From 15 seconds onwards increase the chance to spawn an explosive torpedo instead of a normal torpedo.
	#Maxed at 50 seconds
	var explosive_chance = clamp(((OS.get_ticks_msec()-starting_time) - 15000) / 35000.0, 0, 1)
	#From 30 seconds onwards increase the chance to spawn a fast torpedo in addition to the other torpedoes.
	#Maxed at 80 seconds
	var fast_chance = clamp(((OS.get_ticks_msec()-starting_time) - 30000) / 50000.0, 0, 1)
	for i in range(spawn_amount):
		if randf() < explosive_chance:
			spawn_torpedo(ExplosiveTorpedo)
		else:
			spawn_torpedo(Torpedo)
	if randf() < fast_chance:
		spawn_torpedo(FastTorpedo)

func spawn_torpedo(torpedo_type):
	var torpedo = torpedo_type.instance()
	Game.call_deferred("add_child",torpedo)
	torpedo.set_player(Player)
	var direction = randi()%4
	match direction:
		0:
			torpedo.position = Player.position + Vector2(rand_range(-700, 700), rand_range(-400, -700))
		1:
			torpedo.position = Player.position + Vector2(rand_range(700, 1000), rand_range(-400, 400))
		2:
			torpedo.position = Player.position + Vector2(rand_range(-700, 700), rand_range(400, 700))
		3:
			torpedo.position = Player.position + Vector2(rand_range(-700, -1000), rand_range(-400, 400))
	if torpedo.position.y <= 50 || torpedo.position.y >= Global.ocean_depth - 50:
		torpedo.queue_free()

func spawn_mine_blocker(mine_type):
	for i in range(80):
		var mine = mine_type.instance()
		Game.call_deferred("add_child",mine)
		mine.set_player(Player)
		mine.is_blocker_set(true)
		mine.position = Player.position + Vector2(i * 50 - 2000, 500)

func _on_WaveTimer_timeout():
	spawn_wave()
