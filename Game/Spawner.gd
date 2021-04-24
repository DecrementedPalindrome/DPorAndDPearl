extends Node2D

export (NodePath) var game_path
export (NodePath) var player_path
export (PackedScene) var Mine

var Game
var Player

func _ready():
	randomize()
	Game = get_node(game_path)
	Player = get_node(player_path)
	


func spawn_wave():
	var player_position = Player.position
	for i in range(10):
		var mine = Mine.instance()
		Game.call_deferred("add_child",mine)
		mine.set_player(Player)
		var direction = randi()%4
		match direction:
			0:
				mine.position = player_position + Vector2(rand_range(-700, 700), rand_range(-400, -600))
			1:
				mine.position = player_position + Vector2(rand_range(700, 900), rand_range(-400, 400))
			2:
				mine.position = player_position + Vector2(rand_range(-700, 700), rand_range(400, 600))
			3:
				mine.position = player_position + Vector2(rand_range(-700, -900), rand_range(-400, 400))
		if mine.position.y <= 50 || mine.position.y >= Global.ocean_depth - 50:
			mine.queue_free()



func _on_WaveTimer_timeout():
	spawn_wave()
