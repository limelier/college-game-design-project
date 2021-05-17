extends "res://scripts/EnemyClass.gd"

var sgn=1
func _init():
	 health = 170
	 damage = 5
	 screen_size
	 down_accel = 20
	 down_min_speed = 60
	 score_value = 500
	

func _ready():
	$BulletTimer.wait_time = rand_range(0.5, 1.5)
	$BulletTimer2.wait_time = rand_range(0.5, 1.5)
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	if position.y<screen_size.y/4 and sgn==-1:
		sgn=1
		linear_velocity.y += down_accel*sgn
	if position.y>screen_size.y/2 and sgn==1 :
		sgn=-1
		linear_velocity.y += down_accel*sgn

	if position.x < 0 or position.x >= screen_size.x:
		linear_velocity.x = -linear_velocity.x
		position += linear_velocity * delta
		
	# speed up enemy laterally if not moving
	if abs(linear_velocity.x) < 5:
		linear_velocity.x = sign(linear_velocity.x) * 5
	
	# accelerate enemy if not going down
	if abs(linear_velocity.y) < down_min_speed:
		linear_velocity.y += down_accel*sgn*2
		
		
func _on_BulletTimer_timeout():
	$BulletTimer.wait_time = rand_range(0.4, 1.7)
	
	var bullet1 = Bullet.instance()
	bullet1.damage=damage
	get_parent().add_child(bullet1)
	bullet1.position = $BulletSpawn.global_position

func _on_BulletTimer2_timeout():
	$BulletTimer2.wait_time = rand_range(0.4, 1.7)
	
	var bullet2 = Bullet.instance()
	bullet2.damage=damage
	get_parent().add_child(bullet2)
	bullet2.position = $BulletSpawn2.global_position
