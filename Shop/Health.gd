extends Button

func _ready():
	calculate_visibility()

func calculate_visibility():
	if Upgrades.health_level >= Upgrades.health.size()-1:
		queue_free()
