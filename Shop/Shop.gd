extends Control
	
func _on_Continue_pressed():
	get_tree().change_scene("res://Game/Game.tscn")


func _on_FireRate_pressed():
	if Global.money > Upgrades.fire_rate[Upgrades.fire_rate_level+1].cost:
		Global.money -= Upgrades.fire_rate[Upgrades.fire_rate_level+1].cost
		Upgrades.fire_rate_level += 1
