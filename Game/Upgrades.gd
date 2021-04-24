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
	CostValue.new(25, 4),
	CostValue.new(60, 5),
	CostValue.new(200, 6)
]

var fire_rate = [#Per second
	CostValue.new(0,  0.5),
	CostValue.new(10, 0.25),
	CostValue.new(25, 0.125),
	CostValue.new(60, 0.1),
	CostValue.new(200, 0.8)
]

var health_level = 0
var maxDepth = 300 #Pixels
var fire_rate_level = 0 
var num_bullets = 1 #Per shot
var damage = 1
var oxygen_time = 20 #Seconds
var speed = 300 #Pixels per second
