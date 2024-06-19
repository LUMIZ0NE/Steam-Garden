extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	translate(Vector2.RIGHT.rotated(rotation))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass #e


func _on_animation_finished():
	queue_free()
