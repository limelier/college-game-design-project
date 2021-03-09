extends NinePatchRect


export (PackedScene) var Projectile
var target = Vector2()

var projectileSpawn

func _ready():
	projectileSpawn = $ProjectileSpawnPath/ProjectileSpawn

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		print("firing at ", event.position)
		fire_at(event.position)

func fire_at(target):
	projectileSpawn.offset = randi()
	
	var proj = Projectile.instance()
	proj.position = projectileSpawn.position
	proj.fire(target)
	add_child(proj)
