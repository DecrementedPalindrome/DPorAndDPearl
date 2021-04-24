extends Node
class CostValue:
	var cost
	var value
	
	func _init(c, v):
		cost = c
		value = v

var health = [#Hits
	CostValue.new(0,  2),
	CostValue.new(10, 3),
	CostValue.new(50, 4),
	CostValue.new(100, 5),
	CostValue.new(250, 6)
]

var fire_rate = [#Per second
	CostValue.new(0,  0.5),
	CostValue.new(10, 0.25),
	CostValue.new(50, 0.125),
	CostValue.new(100, 0.1),
	CostValue.new(250, 0.08)
]

var max_depth = [#Pixels
	CostValue.new(0,  800),
	CostValue.new(50, 3000),
	CostValue.new(200, 8000),
	CostValue.new(500, Global.ocean_depth)
]

var health_level = 0
var fire_rate_level = 0
var max_depth_level = 0 
var num_bullets = 1 #Per shot
var damage = 1
var oxygen_time = 20 #Seconds
var speed = 300 #Pixels per second
