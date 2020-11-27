extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var min_speed = 25  # Minimum speed range.
var max_speed = 50  # Maximum speed range.


# Called when the node enters the scene tree for the first time.
func _ready():
	#    $Timer.connect("timeout", self, "_on_Timer_timeout")
	get_node("/root/Main").connect("change_level", self, "_on_change_level")

	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_change_level():
	min_speed = 25 * (get_parent().level)
	max_speed = 50 * (get_parent().level)




func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
