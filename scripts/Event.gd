extends Node


export (PackedScene) var Enemy
export (PackedScene) var Enemy2
export (PackedScene) var EnemyBig

var score=0

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
	
	
func spawn_enemy(type,position,speed,direction,damage=0):
	
	$EnemySpawnPath/EnemySpawn.offset = randi()
	var enemy
	if type%3==0:
		enemy = EnemyBig.instance()
	elif type%3==1:
		enemy = Enemy2.instance()
	else:
		enemy = Enemy.instance()
	
	add_child(enemy)
	enemy.damage+=damage
	enemy.connect("death", self, "_on_Enemy_death")
	enemy.position = position
	
	
	enemy.linear_velocity = Vector2(speed, 0).rotated(direction)
	score+=enemy.score_value

func spawn_enemy_with_random_atr(type):
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
	enemy.position = $EnemySpawnPath/EnemySpawn.position
	
	var direction = $EnemySpawnPath/EnemySpawn.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	
	enemy.linear_velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0).rotated(direction)
	score+=enemy.score_value
	
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
	score+=enemy.score_value

func level1():
	$EnemySpawnTimer.wait_time = rand_range(1.0, 4.0)
	$EnemySpawnPath/EnemySpawn.offset = randi()
	spawn_enemy_with_random_atr(2)
	
func level2():
	$EnemySpawnTimer.wait_time = rand_range(1.0, 3.0)
	if randi()%100>80:
		spawn_enemy_with_random_atr(1)
	else:
		spawn_enemy_with_random_atr(2)
		
func level3():
	$EnemySpawnTimer.wait_time = rand_range(1.0, 3.0)
	if randi()%100>90:
		spawn_enemy_with_random_atr(0)
	elif randi()%100>60:
		spawn_enemy_with_random_atr(1)
	else:
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		
func level4():
	$EnemySpawnTimer.wait_time = rand_range(3.0, 5.0)
	if randi()%100>80:
		spawn_enemy_with_random_atr(0)
	elif randi()%100>60:
		if randi()%100<50:
			spawn_V_group()
		else:
			spawn_Square_group()
	else:
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(1)

func level5():
	$EnemySpawnTimer.wait_time = rand_range(3.0, 4.0)
	if randi()%100>65:
		spawn_enemy_with_random_atr(0)
	elif randi()%100>50:
		if randi()%100<33:
			spawn_V_group()
		elif randi()%100<66:
			spawn_Square_group()
			spawn_enemy_with_random_atr(1)
		else:
			spawn_line_group()
			spawn_line_group()
			
	else:
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(1)


func level6():
	$EnemySpawnTimer.wait_time = rand_range(1.0, 4.0)
	if randi()%100>70:
		spawn_enemy_with_random_atr(0)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
	elif randi()%100>50:
		if randi()%100<33:
			spawn_V_group()
		elif randi()%100<66:
			spawn_Square_group()
			spawn_enemy_with_random_atr(1)
		else:
			spawn_line_group()
			spawn_line_group()
			
	else:
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(1)
		
		
func endgamesession():
	$EnemySpawnTimer.wait_time = rand_range(1.0, 3.0)
	if randi()%100>70:
		spawn_enemy_with_random_atr(0)
		spawn_V_group()
	elif randi()%100>50:
		if randi()%100<33:
			spawn_V_group()
			spawn_V_group()
		elif randi()%100<66:
			spawn_Square_group()
			spawn_enemy_with_random_atr(1)
		else:
			spawn_line_group()
			spawn_line_group()
			
	else:
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(2)
		spawn_enemy_with_random_atr(1)
		spawn_enemy_with_random_atr(1)
