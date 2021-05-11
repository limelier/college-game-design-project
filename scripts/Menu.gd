extends CanvasLayer
signal start_game


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal('start_game')
	get_tree().change_scene("res://scenes/Main.tscn")


func _on_Exit_pressed():
	get_tree().quit()
