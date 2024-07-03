extends Node2D


func _process(_delta):
	change_scene()

func _on_room_2_exit_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Room2"
		Global.transition_scene = true

func _on_room_2_exit_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "Room2":
			print("s")
			get_tree().change_scene_to_file("res://Scenes/world1.tscn")
			Global.finish_changescenes()
