extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if $Player.health <= 0:
		get_tree().change_scene("res://Shop/Shop.tscn")
		
	update_health()

func update_health():
	$HUD/HealthBar/Health.rect_size.x = 350 * (float($Player.health) / Upgrades.health[Upgrades.health_level].value)
