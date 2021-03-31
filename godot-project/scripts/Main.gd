extends Node


export (PackedScene) var Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	randomize()


func _on_EnemySpawnTimer_timeout():
	$EnemySpawnPath/EnemySpawn.offset = randi()
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.connect("death", self, "_on_Enemy_death")
	enemy.position = $EnemySpawnPath/EnemySpawn.position
	
	var direction = $EnemySpawnPath/EnemySpawn.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	
	enemy.linear_velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0).rotated(direction)


func _on_Player_health_updated(health):
	$HUD.update_health(health)

func _on_Enemy_death(score_value):
	$HUD.add_score(score_value)


func _on_Player_weapon_changed(weapon):
	$HUD.change_weapon(weapon)


func new_game():
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.reset_score()
	$HUD.show_message('Get Ready')


func _on_StartTimer_timeout():
	$EnemySpawnTimer.start()


func game_over():
	$EnemySpawnTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group('Enemies', 'queue_free')
