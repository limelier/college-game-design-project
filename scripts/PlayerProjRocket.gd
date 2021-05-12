extends "res://scripts/PlayerBullet.gd"

export var max_speed = 1500
export var acceleration = 150
export (PackedScene) var Explosion
var explosion_scale_mult = 1

func _process(delta):
	position += velocity * delta
	
	if speed < max_speed:
		speed += delta * acceleration
		velocity = velocity.normalized() * speed

func _on_PlayerBullet_body_entered(body):
	var explosion = Explosion.instance()
	explosion.position = position
	explosion.scale *= explosion_scale_mult
	explosion.damage = damage
	get_parent().add_child(explosion)
	._on_PlayerBullet_body_entered(body)
