extends MarginContainer

var score = 0

func _ready():
	$Rows/TopRow/ScoreLabel.text = str(score)

func update_health(value):
	$Rows/TopRow/HealthContainer/HealthBarCenterer/HealthBar.value = value

func add_score(value):
	score += value
	$Rows/TopRow/ScoreLabel.text = str(score)

func change_weapon(weapon):
	$Rows/BottomRow/WeaponDisplay.update_weapon(weapon)
