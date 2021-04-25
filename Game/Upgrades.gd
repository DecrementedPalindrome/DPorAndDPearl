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
	CostValue.new(0,  1000),
	CostValue.new(20, 3000),
	CostValue.new(100, 8000),
	CostValue.new(250, Global.ocean_depth)
]

var num_bullets = [#Per shot
	CostValue.new(0,  1),
	CostValue.new(150, 2),
	CostValue.new(400, 3)
]

var damage = [#Per bullet
	CostValue.new(0,  1),
	CostValue.new(50, 2),
	CostValue.new(200, 3),
	CostValue.new(500, 4)
]

var oxygen = [#Seconds
	CostValue.new(0,  20),
	CostValue.new(15, 40),
	CostValue.new(50, 60),
	CostValue.new(100, 120),
	CostValue.new(200, 360)
]

var speed = [#Pixels per second
	CostValue.new(0,  250),
	CostValue.new(30, 300),
	CostValue.new(75, 350),
	CostValue.new(200, 400),
	CostValue.new(450, 450)
]

var health_level = 0
var fire_rate_level = 0
var max_depth_level = 0
var num_bullets_level = 0
var damage_level = 0
var oxygen_level = 0
var speed_level = 0
