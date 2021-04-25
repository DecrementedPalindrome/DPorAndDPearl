extends Node2D


func _process(delta):
	var time_elapsed = OS.get_ticks_msec()
	if time_elapsed > 3500 && time_elapsed <= 6000:
		var vibration_scale = pow((time_elapsed - 3500)/400.0, 2)
		$FirstTitle.rect_position = Vector2(
			randf()*vibration_scale,
			randf()*vibration_scale
		)
	if time_elapsed > 6000:
		$FirstTitle.visible = false
		$SecondTitle.visible = true
