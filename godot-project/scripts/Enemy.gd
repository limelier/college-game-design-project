extends RigidBody2D

export var min_speed = 100
export var max_speed = 300

export (PackedScene) var Bullet

var health = 20
var damage = 30
var screen_size
var down_accel = 20
var down_min_speed = 50

var score_value = 10
signal death

func _ready():
	$BulletTimer.wait_time = rand_range(1.0, 3.0)
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	# bounce enemy at edge of screen
	if position.x < 0 or position.x >= screen_size.x:
		linear_velocity.x = -linear_velocity.x
		position += linear_velocity * delta
		
	# speed up enemy laterally if not moving
	if abs(linear_velocity.x) < 5:
		linear_velocity.x = sign(linear_velocity.x) * 5
	
	# accelerate enemy if not going down
	if linear_velocity.y < down_min_speed:
		linear_velocity.y += down_accel


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_BulletTimer_timeout():
	$BulletTimer.wait_time = rand_range(1.0, 3.0)
	
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.position = $BulletSpawn.global_position


func damage(amount):
	health -= amount
	if health <= 0:
		emit_signal("death", score_value)
		queue_free()
