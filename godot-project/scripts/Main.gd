extends Node


export (PackedScene) var Enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func _on_EnemySpawnTimer_timeout():
	$EnemySpawnPath/EnemySpawn.offset = randi()
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.position = $EnemySpawnPath/EnemySpawn.position
	
	var direction = $EnemySpawnPath/EnemySpawn.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	
	enemy.linear_velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0).rotated(direction)


func _on_Player_health_updated(health):
	$Health.text = str(health)
