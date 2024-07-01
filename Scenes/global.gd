extends Node

var current_scene = "World"
var transition_scene = false

var player_start_posx = 0
var player_start_posy = 0

var player_exit_room_posx = 0
var player_exit_room_posy = 0

func finish_changescenes():
	if transition_scene == true and current_scene == "World":
		transition_scene = false
		current_scene = "Room2"
	else:
		current_scene = "World"

