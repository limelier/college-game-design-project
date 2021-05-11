extends Area2D

const movement_speed = 400
var screen_size
var health = 100
var damage = 0
var weapon
var weapon_level = 1
var weapon_level_cap = 5
var inputs
var player = 0
var death_pos

onready var weapons = {
	'starter': $Weapons/WeaponStarter,
	'shotgun': $Weapons/WeaponShotgun,
	'rocket': $Weapons/WeaponRocket,
}

signal health_updated
signal health_zero
signal weapon_changed


func start(pos, outside_pos, what_player = 0):
	death_pos = outside_pos
	player = what_player
	position = pos
	emit_signal("health_updated", health)
	show()

func update_controls():
	if player == 0:
		inputs = {'right': "ui_right", 'left': "ui_left", 'down': "ui_down", 
		'up': "ui_up", 'fire': "fire", 'cycle_weapon': "cycle_weapon"}
	elif player == 1:
		inputs = {'right': "p2_right", 'left': "p2_left", 'down': "p2_down", 
		'up': "p2_up", 'fire': "p2_fire", 'cycle_weapon': "p2_cycle_weapon"}

func _ready():
	screen_size = get_viewport_rect().size
	weapon = weapons['starter']
	emit_signal("weapon_changed", weapon)
	hide()

	inputs = {'right': "ui_right", 'left': "ui_left", 'down': "ui_down", 
	'up': "ui_up", 'fire': "p2_fire", 'cycle_weapon': "p2_cycle_weapon"}

func _process(delta):
	if visible:
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



func take_damage(amount):
	health -= amount
	emit_signal("health_updated", health)
	
	if health < 0:
		health = 0
	
	if health == 0:
		position = death_pos
		emit_signal("health_zero")
		hide()
		health = 100


func _on_Player_body_entered(body):
	# enemy collisions
	take_damage(body.damage)
	pass


func _on_Player_area_entered(area):
	# bullets
	if area.is_in_group('enemyBullet'):
		take_damage(area.damage)
	# power pickup
	if area.is_in_group('powerPickup'):
		weapon_level += 1
		if weapon_level > weapon_level_cap:
			weapon_level = weapon_level_cap
		weapon.update_level(weapon_level)
		emit_signal("weapon_changed", weapon)
	# weapon pickup
	if area.is_in_group('weaponPickup'):
		if area.for_weapon == weapon.friendly_name:
			weapon_level += 1
			if weapon_level > weapon_level_cap:
				weapon_level = weapon_level_cap
		else:
			weapon = weapons[area.for_weapon]
		weapon.update_level(weapon_level)
		emit_signal("weapon_changed", weapon)
	
	area.queue_free()
	pass
