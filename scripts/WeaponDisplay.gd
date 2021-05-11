extends MarginContainer

func update_weapon(weapon):
	$Background/Projectile.texture = load('res://resources/sprites/' + weapon.friendly_name + '_weapon_icon.png')
	$Background/Level.text = str(weapon.level)
