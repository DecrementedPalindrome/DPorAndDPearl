extends RigidBody2D

class_name Enemy

var health setget health_set, health_get
var worth setget worth_set, worth_get
var damage_timer = 0

var Player

func _ready():
	$Sprite.visible = true

func set_player(var player):
	Player = player

func health_set(new_health):
	health = new_health

func health_get():
	return health

func worth_set(new_worth):
	worth = new_worth

func worth_get():
	return worth

func _process(delta):
	if position.distance_to(Player.position) > 1000:
		queue_free()
	if damage_timer > 0:
		visible = fmod(damage_timer, 0.05) > 0.025
		damage_timer -= delta
	else:
		visible = true

func damage(var amount):
	health -= amount
	damage_timer = 0.25
	if health <= 0:
		destroy()

func destroy():
	Global.money += worth_get()
	queue_free()

