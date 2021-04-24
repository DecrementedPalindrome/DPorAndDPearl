extends Node2D

export (NodePath) var game_path

var Game

var health
var speed

func _ready():
	Game = get_node(game_path)
	health = Upgrades.health
	speed = Upgrades.speed

func _process(delta):
	processMovement(delta)

func processMovement(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.y = clamp(position.y, 0, Global.ocean_depth-30)
	position.x = clamp(position.x, -5000, 5000)



func hit():
	health -= 1

func _on_Hitbox_body_entered(body):
	body.destroy()
	hit()
