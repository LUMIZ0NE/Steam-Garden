extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()

#Establish a change back to room2 when entering doorway collisionshape
func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "Room3":
			get_tree().change_scene_to_file("res://Scenes/room_2.tscn")
			Global.finish_changescenes()


# Change global variables so that any rooms entered from room3 set the payer position to the correct door
func _on_room_3_exit_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Room3"
		Global.go_room1 = false
		Global.leaving_room3 = true
		Global.transition_scene = true
