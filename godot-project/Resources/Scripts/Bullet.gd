extends KinematicBody2D
signal shoot_enemy

var speed = 750
var velocity = Vector2()

func start(pos, dir):
	rotation = dir
	global_position = pos
	velocity = Vector2(speed, 0)


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func teleport():
	var parent = get_parent()
	if parent.has_method('teleport'):
		parent.teleport()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	emit_signal('shoot_enemy')
	teleport()
	# TO DO: spawn projectile on the enemy side


