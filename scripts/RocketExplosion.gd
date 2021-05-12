extends Area2D

var damage = 10


func _ready():
	rotation = rand_range(0, 2*PI)
	$AnimatedSprite.play()

func _on_TimerUntilHurt_timeout():
	$CollisionShape2D.disabled = false


func _on_AnimatedSprite_animation_finished():
	queue_free()



func _on_RocketExplosion_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
