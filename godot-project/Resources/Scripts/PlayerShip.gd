extends Node2D


func shoot_weapons():
	for child in get_children():
		if child.has_method("shoot"):
			child.shoot()
