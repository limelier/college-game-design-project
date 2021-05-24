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
var sounds = {
	'starter': preload("res://resources/sounds/laser-shot.wav"),
	'shotgun': preload("res://resources/sounds/shotgun-shot.wav"),
	'rocket': preload("res://resources/sounds/rocket-shot.wav"),
}
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

func clear_sounds(node):
	node.queue_free()

func gun_effects():
	var sound_player = AudioStreamPlayer2D.new()
	add_child(sound_player)
	if weapon == weapons['starter']:
		sound_player.stream = sounds['starter']
	elif weapon == weapons['shotgun']:
		sound_player.stream = sounds['shotgun']
	elif weapon == weapons['rocket']:
		sound_player.stream = sounds['rocket']
	sound_player.play()
	sound_player.connect('finished', self, 'clear_sounds', [sound_player])
	
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
			var shot = weapon.fire($BulletSpawn, get_parent())
			if shot:
				gun_effects()



func take_damage(amount):
	health -= amount
	
	if health < 0:
		health = 0
	
	emit_signal("health_updated", health)	
	
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
	elif area.is_in_group('powerPickup'):
		weapon_level += 1
		if weapon_level > weapon_level_cap:
			weapon_level = weapon_level_cap
		weapon.update_level(weapon_level)
		emit_signal("weapon_changed", weapon)
	# weapon pickup
	elif area.is_in_group('weaponPickup'):
		if area.for_weapon == weapon.friendly_name:
			weapon_level += 1
			if weapon_level > weapon_level_cap:
				weapon_level = weapon_level_cap
		else:
			weapon = weapons[area.for_weapon]
		weapon.update_level(weapon_level)
		emit_signal("weapon_changed", weapon)
	# health pickup
	elif area.is_in_group('healthPickup'):
		self.health += area.amount
		if self.health > 100:
			self.health = 100
		emit_signal("health_updated", health)
	elif area.is_in_group('rocketExplosion'):
		# do not queue_free explosions, they've got it handled
		return
	
	area.queue_free()
	pass
