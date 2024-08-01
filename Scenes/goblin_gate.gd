extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_room_2_gate_close():
	$AnimatedSprite2D.play("close")




func _on_room_2_gate_open():
	Global.room2_complete = true
	self.queue_free()
