extends Area2D

const movement_speed = 400
var screen_size
var health = 100

signal health_updated

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * movement_speed
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _input(event):
	if Input.is_action_just_pressed("fire"):
		$Weapon.fire($BulletSpawn, get_parent())


func damage(amount):
	health -= amount
	emit_signal("health_updated", health)
	
	if health < 0:
		health = 0
	
	if health == 0:
		queue_free()


func _on_Player_body_entered(body):
	# enemy collisions
	damage(body.damage)


func _on_Player_area_entered(area):
	# bullets
	damage(area.damage)
	area.queue_free()
