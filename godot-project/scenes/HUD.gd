extends MarginContainer

var score = 0

func _ready():
	$HBoxContainer/ScoreLabel.text = str(score)

func update_health(value):
	$HBoxContainer/HealthContainer/HealthBarCenterer/HealthBar.value = value

func add_score(value):
	score += value
	$HBoxContainer/ScoreLabel.text = str(score)
