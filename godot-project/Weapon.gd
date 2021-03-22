extends Node

export (PackedScene) var Projectile

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn(bullet_spawn, parent):
	var projectile = Projectile.instance()
	parent.add_child(projectile)
	projectile.position = bullet_spawn.global_position


func fire(bullet_spawn, parent):
	if $Cooldown.is_stopped():
		$Cooldown.start()
		spawn(bullet_spawn, parent)

