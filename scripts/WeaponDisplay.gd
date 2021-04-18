extends MarginContainer

var projectile: Node

func update_weapon(weapon):
	$Background/Level.text = str(weapon.level)
	if (projectile):
		projectile.queue_free()
	projectile = weapon.Projectile.instance()
	$Background/Projectile.texture = projectile.get_node("Sprite").texture
