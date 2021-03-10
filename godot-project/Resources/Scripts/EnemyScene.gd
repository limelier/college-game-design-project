extends Node2D

export (PackedScene) var Projectile

func _ready(): 
	get_attacked()
	
	
func get_attacked():
	$ProjectilePath/ProjectileSpawnLocation.offset = randi()
	
	var proj = Projectile.instance()
	add_child(proj)
	
	var direction = $ProjectilePath/ProjectileSpawnLocation.rotation + PI / 2
	
	proj.start($ProjectilePath/ProjectileSpawnLocation.position, direction)
	direction += rand_range(-PI / 4, PI / 4)
	proj.rotation = direction
	
	# proj.linear_velocity = Vector2(proj.speed, 0)
	# proj.linear_velocity = proj.linear_velocity.rotated(direction)

