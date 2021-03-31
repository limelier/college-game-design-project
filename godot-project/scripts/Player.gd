extends Area2D

const movement_speed = 400
var screen_size
var health = 100
var selected_weapon = 0
var weapon

signal health_updated
signal health_zero


func start(pos):
	position = pos
	emit_signal("health_updated", health)
	show()

func _ready():
	screen_size = get_viewport_rect().size
	weapon = $Weapons.get_child(selected_weapon)
	hide()

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
	
	if Input.is_action_pressed("fire"):
		weapon.fire($BulletSpawn, get_parent())
		
	if Input.is_action_just_pressed("cycle_weapon"):
		selected_weapon = (selected_weapon + 1) % $Weapons.get_child_count()
		weapon = $Weapons.get_child(selected_weapon)


func damage(amount):
	health -= amount
	emit_signal("health_updated", health)
	
	if health < 0:
		health = 0
	
	if health == 0:
		emit_signal("health_zero")
		hide()
		health = 100


func _on_Player_body_entered(body):
	# enemy collisions
	damage(body.damage)


func _on_Player_area_entered(area):
	# bullets
	damage(area.damage)
	area.queue_free()
