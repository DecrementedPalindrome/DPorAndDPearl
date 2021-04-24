extends Node2D

export (NodePath) var game_path

export (PackedScene) var Bullet

var Game

var health
var speed

var last_process_time = 0
var last_bullet_shot = 0
var damage_timer = 0

func _ready():
	Game = get_node(game_path)
	health = Upgrades.health[Upgrades.health_level].value
	speed = Upgrades.speed

func _process(delta):
	processMovement(delta)
	if (last_process_time + delta) > (last_bullet_shot + Upgrades.fire_rate[Upgrades.fire_rate_level].value):
		spawn_bullet()
		last_bullet_shot = last_process_time + delta
	last_process_time += delta
	
	if damage_timer > 0:
		visible = fmod(damage_timer, 0.05) > 0.025
		damage_timer -= delta
	else:
		visible = true

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
	position.y = clamp(position.y, 0, Upgrades.max_depth[Upgrades.max_depth_level].value-30)
	position.x = clamp(position.x, -5000, 5000)

func spawn_bullet():
	var bullet = Bullet.instance()
	Game.call_deferred("add_child",bullet)
	bullet.position = position
	bullet.linear_velocity = (get_viewport().get_mouse_position()-Vector2(600, 350)).normalized() * Upgrades.speed*3
	bullet.set_player(self)

func hit():
	if damage_timer <= 0:
		health -= 1
		damage_timer = 1

func _on_Hitbox_body_entered(body):
	body.destroy()
	hit()
