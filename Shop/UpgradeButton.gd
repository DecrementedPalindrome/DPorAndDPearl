extends Control

export(String, "Health", "FireRate", "Damage", "Speed", "Oxygen", "Bullets", "Depth") var type

export(Texture) var normal
export(Texture) var pressed

func get_level():
	match type:
		"Health":
			return Upgrades.health_level
		"FireRate":
			return Upgrades.fire_rate_level
		"Damage":
			return Upgrades.damage_level
		"Speed":
			return Upgrades.speed_level
		"Oxygen":
			return Upgrades.oxygen_level
		"Bullets":
			return Upgrades.num_bullets_level
		"Depth":
			return Upgrades.max_depth_level

func get_max_level():
	match type:
		"Health":
			return Upgrades.health.size()
		"FireRate":
			return Upgrades.fire_rate.size()
		"Damage":
			return Upgrades.damage.size()
		"Speed":
			return Upgrades.speed.size()
		"Oxygen":
			return Upgrades.oxygen.size()
		"Bullets":
			return Upgrades.num_bullets.size()
		"Depth":
			return Upgrades.max_depth.size()

func set_level(new_level):
	match type:
		"Health":
			Upgrades.health_level = new_level
		"FireRate":
			Upgrades.fire_rate_level = new_level
		"Damage":
			Upgrades.damage_level = new_level
		"Speed":
			Upgrades.speed_level = new_level
		"Oxygen":
			Upgrades.oxygen_level = new_level
		"Bullets":
			Upgrades.num_bullets_level = new_level
		"Depth":
			Upgrades.max_depth_level = new_level

func get_cost():
	match type:
		"Health":
			return Upgrades.health[Upgrades.health_level+1].cost
		"FireRate":
			return Upgrades.fire_rate[Upgrades.fire_rate_level+1].cost
		"Damage":
			return Upgrades.damage[Upgrades.damage_level+1].cost
		"Speed":
			return Upgrades.speed[Upgrades.speed_level+1].cost
		"Oxygen":
			return Upgrades.oxygen[Upgrades.oxygen_level+1].cost
		"Bullets":
			return Upgrades.num_bullets[Upgrades.num_bullets_level+1].cost
		"Depth":
			return Upgrades.max_depth[Upgrades.max_depth_level+1].cost

func _ready():
	$Button.texture_normal = normal
	$Button.texture_pressed = pressed
	calculate_cost()

func calculate_cost():
	if get_level() >= get_max_level():
		queue_free()
		return
	$Cost.text = str(get_cost())


func _on_Button_pressed():
	if Global.money >= get_cost():
		Global.money -= get_cost()
		set_level(get_level() + 1)
		calculate_cost()
	
