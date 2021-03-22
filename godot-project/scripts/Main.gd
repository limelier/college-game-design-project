extends Node


export (PackedScene) var Enemy
export (PackedScene) var Enemy2
export (PackedScene) var EnemyBig


var temp =0
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func _on_EnemySpawnTimer_timeout():
	var type= randi()
	$EnemySpawnPath/EnemySpawn.offset = randi()
	var enemy
	if type%3==0 and temp==0:
		enemy = EnemyBig.instance()
		temp=1
	elif type%3==1:
		enemy = Enemy2.instance()
	else:
		enemy = Enemy.instance()

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
