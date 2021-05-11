extends "res://scripts/PickupBase.gd"

var for_weapon

func update_weapon(weapon):
	for_weapon = weapon
	var sprite_name
	match weapon:
		'starter':
			sprite_name = 'player_projectile.png'
		'shotgun':
			sprite_name = 'player_projectile_pellet.png'
		'rocket':
			sprite_name = 'player_projectile_rocket.png'
	$WeaponSprite.texture = load('res://resources/sprites/' + sprite_name)
