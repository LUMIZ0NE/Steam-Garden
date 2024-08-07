extends CharacterBody2D


func _physics_process(delta):
	pass

func _on_gem_collect_body_entered(body):
	if body.has_method("player"):
		get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
