extends Node

signal change_level

export (PackedScene) var Mob
var score
var level
var min_speed
var max_speed

func _ready():
	randomize()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	$DeathSound.play()
	$LevelTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()
	level = 1
	min_speed = 25
	max_speed = 50

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$LevelTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(self.min_speed, self.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	print("Mob speed: min = " + str(self.min_speed) + " max = " + str(self.max_speed))


func _on_LevelTimer_timeout():
	level = level + 1
	min_speed = 25 * level
	max_speed = 50 * level
#	$LevelLabel.text = "Level " + str(level)
	emit_signal("change_level")
	$HUD.show_message("Changing Speed!")
	get_tree().call_group("mobs", "queue_free")

