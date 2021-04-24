extends Node2D

var health
var speed

func _ready():
	health = Upgrades.health
	speed = Upgrades.speed

func _process(delta):
	processMovement(delta)

func _on_ObstacleCollider_body_entered(_body):
	pass

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

