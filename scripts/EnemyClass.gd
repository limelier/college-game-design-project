extends RigidBody2D

export var min_speed = 20
export var max_speed = 100

export (PackedScene) var Bullet

var health
var screen_size
var down_min_speed
var down_accel
var score_value = 10
var damage

signal death

func _ready():
	$BulletTimer.wait_time = rand_range(1.0, 3.0)
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	
	# bounce enemy at edge of screen
	#if position.x < 20 or position.x >= screen_size.x-20:
	#	linear_velocity.x = -linear_velocity.x 
	#	position += linear_velocity * delta
	if position.x<20:
		linear_velocity.x = abs(linear_velocity.x) 
		position += linear_velocity * delta
	if position.x >=screen_size.x-20:
		linear_velocity.x = abs(linear_velocity.x)*(-1) 
		position += linear_velocity * delta
	# speed up enemy laterally if not moving
	if abs(linear_velocity.x) < 40:
		linear_velocity.x += sign(linear_velocity.x)*10
	
	# accelerate enemy if not going down
	if linear_velocity.y < down_min_speed:
		linear_velocity.y += down_accel


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

	
func _on_BulletTimer_timeout():
	$BulletTimer.wait_time = rand_range(1.0, 3.0)
	
	var bullet = Bullet.instance()
	bullet.damage=damage
	get_parent().add_child(bullet)
	bullet.position = $BulletSpawn.global_position


func damage(amount):
	health -= amount
	if health <= 0:
		print(position)
		print(score_value)
		emit_signal("death", position, score_value)
		queue_free()
