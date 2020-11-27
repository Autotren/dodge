extends CanvasLayer

export var level = 1
signal start_game

func update_highscore():
	$Highscore.text = "Highscore\n" + str(Globals.highscore)

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	update_highscore()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	$LevelLabel.text = "Level " + str(get_parent().level)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	level = 1
	$LevelLabel.text = "Level " + str(level)
	

func _on_MessageTimer_timeout():
	$Message.hide()
	



func _on_LevelTimer_timeout():
	pass # Replace with function body.
