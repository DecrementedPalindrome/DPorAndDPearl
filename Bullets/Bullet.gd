extends RigidBody2D

class_name Bullet

func destroy():
	queue_free()

var Player

func set_player(var player):
	Player = player

func _process(delta):
	if position.distance_to(Player.position) > 1000:
		queue_free()
