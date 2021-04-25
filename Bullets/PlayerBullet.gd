extends Bullet

func _on_Hitbox_body_entered(body):
	body.damage(Upgrades.damage[Upgrades.damage_level].value)
	destroy()
