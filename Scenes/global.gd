extends Node

var current_scene = "World"
var transition_scene = false

var player_start_posx = 0
var player_start_posy = 0

var player_exit_room_posx = 0
var player_exit_room_posy = 0

func finish_changescenes():
	print(str(transition_scene))
	transition_scene = false
	if current_scene == "World":
		print("enter Room2")
		current_scene = "Room2"
	else:
		print("exit room2")
		current_scene = "World"


