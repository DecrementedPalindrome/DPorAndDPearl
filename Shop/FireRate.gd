extends Button

func _ready():
	calculate_visibility()

func calculate_visibility():
	if Upgrades.fire_rate_level >= Upgrades.fire_rate.size():
		queue_free()
