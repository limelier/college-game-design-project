extends Area2D

const movement_speed = 400
var screen_size
var health = 100
var selected_weapon = 0
var damage = 0
var weapon
var inputs
var player = 0
signal health_updated
signal health_zero
signal weapon_changed


func start(pos):
	position = pos
	emit_signal("health_updated", health)
	show()

func _ready():
	screen_size = get_viewport_rect().size
	weapon = $Weapons.get_child(selected_weapon)
	hide()
	change_weapon(0)
	if player == 0:
		inputs = {'right': "ui_right", 'left': "ui_left", 'down': "ui_down", 
		'up': "ui_up", 'fire': "fire", 'cycle_weapon': "cycle_weapon"}
	elif player == 1:
		inputs = {'right': "p2_right", 'left': "p2_left", 'down': "p2_down", 
		'up': "p2_up", 'fire': "p2_fire", 'cycle_weapon': "p2_cycle_weapon"}

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed(inputs['right']):
		velocity.x += 1
	if Input.is_action_pressed(inputs['left']):
		velocity.x -= 1
	if Input.is_action_pressed(inputs['down']):
		velocity.y += 1
	if Input.is_action_pressed(inputs['up']):
		velocity.y -= 1
	velocity = velocity.normalized() * movement_speed
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if Input.is_action_pressed(inputs['fire']):
		weapon.fire($BulletSpawn, get_parent())
		
	if Input.is_action_just_pressed(inputs['cycle_weapon']):
		change_weapon()

func change_weapon(index = null):
	if index == null:
		index = (selected_weapon + 1) % $Weapons.get_child_count()
	selected_weapon = index
	weapon = $Weapons.get_child(selected_weapon)
	emit_signal("weapon_changed", weapon)

func take_damage(amount):
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
	take_damage(body.damage)
	pass


func _on_Player_area_entered(area):
	# bullets
	take_damage(area.damage)
	area.queue_free()
	pass
