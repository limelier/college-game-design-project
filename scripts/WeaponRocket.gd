extends "res://scripts/Weapon.gd"

var init_cooldown = $Cooldown.wait_time

export (int) var init_damage = 10
export (int) var init_accel = 150
export (int) var init_max_speed = 1500
var explosion_scale_mult = 1

var damage = init_damage+10
var accel = init_accel
var max_speed = init_max_speed

func _ready():
	init_cooldown = $Cooldown.wait_time
	update_level(level)

func update_level(level):
	.update_level(level)
	# 100%, 8/9, 8/10, 8/11, ...
	$Cooldown.wait_time = init_cooldown * (8.0 / (8.0 + level - 1))
	var factor = 1.0 + float(level - 1) / 4.0
	damage = factor * init_damage
	accel = factor * init_accel
	max_speed = factor * init_max_speed
	explosion_scale_mult += 0.25
	

func spawn(bullet_spawn, parent):
	var projectile = Projectile.instance()
	projectile.position = bullet_spawn.global_position
	projectile.damage = damage
	projectile.acceleration = accel
	projectile.max_speed = max_speed
	projectile.explosion_scale_mult = explosion_scale_mult
	projectile.type = 'rocket'
	parent.add_child(projectile)
	
