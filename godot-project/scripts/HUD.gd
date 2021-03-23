extends CanvasLayer

signal start_game

var score = 0

func _ready():
	$Display/HBoxContainer/ScoreLabel.text = str(score)

func update_health(value):
	$Display/HBoxContainer/HealthContainer/HealthBarCenterer/HealthBar.value = value

func add_score(value):
	score += value
	$Display/HBoxContainer/ScoreLabel.text = str(score)
	
func reset_score():
	score = 0
	
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message('Game Over')
	yield($MessageTimer, 'timeout')
	
	$Message.text = 'Placeholder!'
	$Message.show()
	
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal('start_game')
