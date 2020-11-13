extends CanvasLayer

export var level = 1
export var scr = 0
signal start_game
signal change_level

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
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
func update_score(score):
	scr = (score - (level-1)*5)
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	level = 1
	$LevelLabel.text = "Level " + str(level)
	

func _on_MessageTimer_timeout():
	$Message.hide()
	
func _process(delta):
	if scr == 5:
		level = level + 1
		$LevelLabel.text = "Level " + str(level)
		scr = 0
		emit_signal("change_level")

