extends "res://scripts/EnemyClass.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func  _init():
	health = 40
	damage = 20
	screen_size
	down_accel = 5
	down_min_speed = 35
	score_value=300

# Called when the node enters the scene tree for the first time.
func _ready():
	$BulletTimer.wait_time = rand_range(1.0, 3.0)
	screen_size = get_viewport_rect().size
	
func damage(amount):
	health -= amount
	if health <= 0:
		emit_signal("death", score_value)
		queue_free()

func _on_BulletTimer_timeout():
	$BulletTimer.wait_time = rand_range(1.0, 3.0)
	
	var bullet1 = Bullet.instance()
	get_parent().add_child(bullet1)
	bullet1.position = $BulletSpawn.global_position
	
	var bullet2 = Bullet.instance()
	get_parent().add_child(bullet2)
	bullet2.position = $BulletSpawn2.global_position


