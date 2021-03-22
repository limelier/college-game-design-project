extends Node

export (PackedScene) var Projectile
export (int) var level = 1


func _ready():
	update_level(level)


func update_level(level):
	self.level = level


func spawn(bullet_spawn, parent):
	var projectile = Projectile.instance()
	parent.add_child(projectile)
	projectile.position = bullet_spawn.global_position


func fire(bullet_spawn, parent):
	if $Cooldown.is_stopped():
		$Cooldown.start()
		spawn(bullet_spawn, parent)

