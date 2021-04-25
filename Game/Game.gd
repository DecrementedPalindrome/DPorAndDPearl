extends Node2D

var oxygen

# Called when the node enters the scene tree for the first time.
func _ready():
	oxygen = Upgrades.oxygen[Upgrades.oxygen_level].value


func _process(delta):
	update_health()
	update_oxygen(delta)

func update_health():
	$HUD/HealthBar/Health.rect_size.x = 350 * (float($Player.health) / Upgrades.health[Upgrades.health_level].value)
	if $Player.health <= 0:
		end_game()

func update_oxygen(delta):
	oxygen -= delta
	if $Player.position.y < 10 && oxygen < Upgrades.oxygen[Upgrades.oxygen_level].value:
		oxygen = clamp(oxygen + delta * 5, 0, Upgrades.oxygen[Upgrades.oxygen_level].value)
	$HUD/OxygenBar/Oxygen.rect_size.x = 350 * (oxygen / Upgrades.oxygen[Upgrades.oxygen_level].value)
	if oxygen < 0:
		end_game()

func end_game():
	get_tree().change_scene("res://Shop/Shop.tscn")
