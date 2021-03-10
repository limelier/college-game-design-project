extends Node2D

export (PackedScene) var Projectile

func _ready():
	randomize() # necessary for randomness
	get_attacked()
	
func get_attacked():
	print('enemy getting attacked')
	$ProjectilePath/ProjectileSpawnLocation.offset = randi()
	
	var proj = Projectile.instance()
	add_child(proj)
	
	var direction = $ProjectilePath/ProjectileSpawnLocation.rotation - PI / 2
	direction += rand_range(-PI / 6, PI / 6)
	proj.start($ProjectilePath/ProjectileSpawnLocation.position, direction)
	
	# proj.linear_velocity = Vector2(proj.speed, 0)
	# proj.linear_velocity = proj.linear_velocity.rotated(direction)

