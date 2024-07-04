extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.first_load == true:
		$Player.position.x = Global.player_start_posx
		$Player.position.y = Global.player_start_posy
		Global.first_load = false
	else:
		$Player.position.x = Global.player_exit_room_posx
		$Player.position.y = Global.player_exit_room_posy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_room_2_enter_body_entered(body):
	if body.has_method("player"):
		
		Global.transition_scene = true


func _on_room_2_enter_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "World":
			get_tree().change_scene_to_file("res://Scenes/room_2.tscn")
			Global.finish_changescenes()
