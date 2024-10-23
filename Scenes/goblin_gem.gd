extends CharacterBody2D

func _physics_process(delta):
	pass

func _on_gem_collect_body_entered(body):
	# Complete win condition and load end screen when player makes contact with end goal
	if body.has_method("player"):
		Global.win_check = true
		get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
