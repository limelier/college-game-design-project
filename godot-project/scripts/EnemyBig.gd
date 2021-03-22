extends RigidBody2D

export var min_speed = 20
export var max_speed = 80

export (PackedScene) var Bullet

var health = 70
var damage = 20
var screen_size
var down_accel = 2
var down_min_speed = 60

var sgn =1
var score_value = 1000
signal death

func _ready():
	$BulletTimer.wait_time = rand_range(1.0, 3.0)
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	if position.y<screen_size.y/4 and sgn==-1:
		linear_velocity.y += down_accel*sgn
		sgn=1
	if position.y>screen_size.y/2 and sgn==1 :
		linear_velocity.y += down_accel*sgn
		sgn=-1
	if position.x < 0 or position.x >= screen_size.x:
		linear_velocity.x = -linear_velocity.x
		position += linear_velocity * delta
		
	# speed up enemy laterally if not moving
	if abs(linear_velocity.x) < 5:
		linear_velocity.x = sign(linear_velocity.x) * 5
	
	# accelerate enemy if not going down
	if abs(linear_velocity.y) < down_min_speed:
		linear_velocity.y += down_accel*sgn
	
		
	#if position.y>screen_size.y/2 :
	#	linear_velocity.y = (-1)*down_accel*2

	
	
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_BulletTimer_timeout():
	$BulletTimer.wait_time = rand_range(1.0, 3.0)
	
	var bullet1 = Bullet.instance()
	get_parent().add_child(bullet1)
	bullet1.position = $BulletSpawn.global_position
	
	var bullet2 = Bullet.instance()
	get_parent().add_child(bullet2)
	bullet2.position = $BulletSpawn2.global_position


func damage(amount):
	health -= amount
	if health <= 0:
		emit_signal("death", score_value)
		queue_free()
