extends Node

var current_scene = "World"
var transition_scene = false

var first_load = true

var player_start_posx = 264
var player_start_posy = 169

var player_exit_room_posx = 604
var player_exit_room_posy = 539

func finish_changescenes():
	print(str(transition_scene))
	transition_scene = false
	if current_scene == "World":
		print("enter Room2")
		current_scene = "Room2"
	else:
		print("exit room2")
		current_scene = "World"


