extends "res://scripts/PlayerBullet.gd"

export var max_speed = 1500
export var acceleration = 150

func _process(delta):
	position += velocity * delta
	
	if speed < max_speed:
		speed += delta * acceleration
		velocity = velocity.normalized() * speed
