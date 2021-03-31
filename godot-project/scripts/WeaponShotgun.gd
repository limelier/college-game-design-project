extends "res://scripts/Weapon.gd"

var pellets
export (float) var spread = PI / 6

func _ready():
	update_level(level)

func update_level(level):
	.update_level(level)
	pellets = 2 + level
	spread = PI / 6 * (1 + .1 * level)

func spawn(bullet_spawn, parent):
	var spread_between = spread / (pellets - 1)
	var initial_rotation = -(spread / 2)
	
	for i in range(0, pellets):
		var projectile = Projectile.instance()
		projectile.rotation = initial_rotation + i * spread_between
		parent.add_child(projectile)
		projectile.position = bullet_spawn.global_position
