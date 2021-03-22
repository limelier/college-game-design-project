extends Area2D

var velocity = Vector2()
const speed = 500
const damage = 10

func _ready():
	velocity = Vector2.UP * speed


func _process(delta):
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
	print("FriendlyBullet out of screen")

func _on_PlayerBullet_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
	self.queue_free()
