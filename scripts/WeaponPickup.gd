extends "res://scripts/PickupBase.gd"

var for_weapon

func update_weapon(weapon):
	for_weapon = weapon
	var sprite_name
	match weapon:
		'starter':
			sprite_name = 'starter_weapon_icon.png'
		'shotgun':
			sprite_name = 'shotgun_weapon_icon.png'
		'rocket':
			sprite_name = 'rocket_weapon_icon.png'
		_:
			sprite_name = 'starter_weapon_icon.png'
	$WeaponSprite.texture = load('res://resources/sprites/' + sprite_name)
