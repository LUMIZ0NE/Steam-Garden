extends Node

#initial load variables
var current_scene = "World"
var transition_scene = false
var go_room1 = false
var leaving_room3 = false
var first_load = true

#player starting position backups
var player_start_posx = 264
var player_start_posy = 169

var player_exit_room_posx = 604
var player_exit_room_posy = 607

var player_enter_room_posx = 300
var player_enter_room_posy = 652

#room 2 checks
var player_current_atk = false
var room2_complete = false

#stats tracking
var win_check = false
var goblins_killed = 0
var player_health = 0 
var waves = 0

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
		


