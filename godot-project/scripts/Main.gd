extends Node


export (PackedScene) var Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
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
	$CanvasLayer/HUD.update_health(health)

func _on_Enemy_death(score_value):
	$CanvasLayer/HUD.add_score(score_value)


func _on_Player_weapon_changed(weapon):
	$CanvasLayer/HUD.change_weapon(weapon)
