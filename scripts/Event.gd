extends Node


export (PackedScene) var Enemy
export (PackedScene) var Enemy2
export (PackedScene) var EnemyBig


func spawn_line_group():
	var direction = $EnemySpawnPath/EnemySpawn.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	
	var type= randi()
	$EnemySpawnPath/EnemySpawn.offset = randi()
	var position=$EnemySpawnPath/EnemySpawn.position
	for i in range(0,4):	
		spawn_enemy(2,Vector2(position.x+i*40,7+i*20),50,direction)
	

func spawn_Square_group():
	var direction = $EnemySpawnPath/EnemySpawn.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	$EnemySpawnPath/EnemySpawn.offset = randi()
	var position=$EnemySpawnPath/EnemySpawn.position
	
	spawn_enemy(2,position,50,direction)
	spawn_enemy(2,Vector2(position.x+80,position.y),50,direction)
	spawn_enemy(2,Vector2(position.x+80,position.y+80),50,direction)
	spawn_enemy(2,Vector2(position.x,position.y+80),50,direction)
	
func spawn_V_group():
	var direction = $EnemySpawnPath/EnemySpawn.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	
	var type= randi()
	#$EnemySpawnPath/EnemySpawn.offset = type
	var screen_size=get_viewport().size
	spawn_enemy(1,Vector2(screen_size.x/2,7),70,direction)
	for i in range(1,3):		
		spawn_enemy(2,Vector2(screen_size.x/2 + i*40,7 + i*20),70,direction)
		spawn_enemy(2,Vector2(screen_size.x/2 - i*40,7 + i*20),70,direction)
	
	
func spawn_enemy(type,position,speed,direction):
	
	$EnemySpawnPath/EnemySpawn.offset = randi()
	var enemy
	if type%3==0:
		enemy = EnemyBig.instance()
	elif type%3==1:
		enemy = Enemy2.instance()
	else:
		enemy = Enemy.instance()

	add_child(enemy)
	
	enemy.connect("death", self, "_on_Enemy_death")
	enemy.position = position
	
	
	enemy.linear_velocity = Vector2(speed, 0).rotated(direction)
	
func spawn_Random_enemy():
	var type= randi()
	$EnemySpawnPath/EnemySpawn.offset = randi()
	var enemy
	var temp
	if type%3==0:
		enemy = EnemyBig.instance()
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
