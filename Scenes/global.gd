extends Node

var current_scene = "World"
var transition_scene = false
var go_room1 = false

var first_load = true

var player_start_posx = 264
var player_start_posy = 169

var player_exit_room_posx = 604
var player_exit_room_posy = 607

var player_current_atk = false
var room2_complete = false

func finish_changescenes():
	print(str(transition_scene))
	transition_scene = false
	if current_scene == "World" or "Room3":
		print("enter Room2")
		current_scene = "Room2"
	elif current_scene == "Room2":
		print("exit room2")
		if go_room1 == true:
			current_scene = "World"
		else:
			current_scene = "Room3"
		


