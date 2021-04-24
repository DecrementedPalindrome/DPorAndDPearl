extends Node2D

var Player

func _ready():
	$Sprite.visible = true

func set_player(var player):
	Player = player

func _process(delta):
	if position.distance_to(Player.position) > 1000:
		queue_free()

func destroy():
	queue_free()
