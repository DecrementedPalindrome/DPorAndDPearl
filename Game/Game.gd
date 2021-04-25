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
	var breathing = false
	if $Player.position.y < 10 && oxygen < Upgrades.oxygen[Upgrades.oxygen_level].value:
		breathing = true
		var refill_rate = Upgrades.oxygen[Upgrades.oxygen_level].value / 3 # 3 Seconds for a full refill
		oxygen = clamp(oxygen + delta * refill_rate, 0, Upgrades.oxygen[Upgrades.oxygen_level].value)
	$HUD/OxygenBar/Oxygen.rect_size.x = 350 * (oxygen / Upgrades.oxygen[Upgrades.oxygen_level].value)
	if oxygen < 0:
		end_game()
	#Play warning sound
	if oxygen < 6 && !breathing:
		if oxygen < 2:
			$HUD/OxygenWarningCritical.play()
		else:
			if $HUD/OxygenWarning.playing == false:
				$HUD/OxygenWarning.play()
	if $HUD/OxygenWarning.playing == true && (oxygen >= 6 || breathing):
		$HUD/OxygenWarning.stop()
	if $HUD/OxygenWarningCritical.playing == true && (oxygen >= 2 || breathing):
		$HUD/OxygenWarningCritical.stop()

func end_game():
	get_tree().change_scene("res://Shop/Shop.tscn")
