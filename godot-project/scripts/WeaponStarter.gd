extends "res://scripts/Weapon.gd"

var init_cooldown = $Cooldown.wait_time

func _ready():
	init_cooldown = $Cooldown.wait_time
	update_level(level)

func update_level(level):
	.update_level(level)
	# 100%, 4/5, 4/6, 4/7, ...
	$Cooldown.wait_time = init_cooldown * (4.0 / (4.0 + level - 1))
	print($Cooldown.wait_time)
