extends Area2D

var velocity = Vector2()
const speed = 300
const damage = 10

func _ready():
	velocity = Vector2.DOWN * speed
	

func _process(delta):
	position += velocity * delta


func _on_VisibilityNotifier2D_screen_exited():
<<<<<<< Updated upstream
	self.queue_free()
=======
	self.free()
>>>>>>> Stashed changes
	print("enemy bullet out of screen")


