extends TextureButton

func _on_PlayButton_pressed():
	Upgrades.health_level = 0
	Upgrades.fire_rate_level = 0
	Upgrades.max_depth_level = 0
	Upgrades.num_bullets_level = 0
	Upgrades.damage_level = 0
	Upgrades.oxygen_level = 0
	Upgrades.speed_level = 0
	Global.money = 0
	get_tree().change_scene("res://Game/Game.tscn")
