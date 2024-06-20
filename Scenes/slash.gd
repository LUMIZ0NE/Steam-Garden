extends Area2D
signal attack_used
const PLAYER = preload("res://Scenes/player.tscn")
var is_ready: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	translate(Vector2.RIGHT.rotated(rotation))
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("attack") and is_ready:
		print("yes")
		is_ready = false
		show()
		attack_used.emit()

func _on_slash_cooldown_timeout():
	is_ready = true

func _on_animation_finished():
	queue_free()
