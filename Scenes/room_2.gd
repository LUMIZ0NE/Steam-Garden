extends Node2D
# set values for first load of scene
@onready var goblin_gate = $GoblinGate
signal gate_close
signal gate_open
const goblin = preload("res://scenes/goblin.tscn")
var goblins_killed = 0
var goblin_wave = 1

func _ready():
	#sets player position to the doorway entered
	if Global.leaving_room3 == true:
		$Player.position.x = Global.player_enter_room_posx
		$Player.position.y = Global.player_enter_room_posy
		Global.leaving_room3 = false
	#default spawn position for the room
	else:
		$Player.position.x = 600
		$Player.position.y = 9
	# clear all hostiles and potential obstacles to avoid issue with re-entry
	if Global.room2_complete == true:
		$Goblin.queue_free()
		$GateCheck.queue_free()
		$GoblinGate.queue_free()
		$Wave2.queue_free()
	goblin_gate.hide()

func _process(_delta):
	change_scene()
	gate_requirements_met()
	track_stats()

# for movement between rooms
func _on_room_2_exit_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Room2"
		Global.go_room1 = true
		Global.transition_scene = true

func _on_room_2_exit_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "Room2":
			print("s")
			if Global.go_room1 == true:
				get_tree().change_scene_to_file("res://Scenes/world1.tscn")
			else:
				get_tree().change_scene_to_file("res://Scenes/room_3.tscn")
			Global.finish_changescenes()

# activate the gate requirements and the enemy waves once player passes certain area in the room 
func _on_gate_check_body_entered(body):
	if body.has_method("player"):
		goblin_gate.show()
		gate_close.emit()
		spawn_goblin()
		$GateCheck.queue_free()

func spawn_goblin():
	var spawnpoint = $SpawnPoints/Point1
	$Goblin.global_position = spawnpoint.global_position
	
# Check if needs are met for gate to open
func gate_requirements_met():
	if goblins_killed >= 3:
		gate_open.emit()

# track progress towards completion of gate requirements and activate second wave when needed
func _on_goblin_goblin_killed():
	goblins_killed = goblins_killed + 1
	if goblins_killed == 1:
		wave_load()
	

# sets position of wave 2 goblins to within the room
func wave_load():
	goblin_wave = 2
	$Wave2/Goblin.global_position = $SpawnPoints/Point1.global_position
	$Wave2/Goblin2.global_position = $SpawnPoints/Point2.global_position

# more scene change factors
func _on_room_3_enter_body_entered(body):
	if body.has_method("player"):
		Global.current_scene = "Room2"
		Global.go_room1 = false
		Global.transition_scene = true


func _on_room_3_enter_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
		

# keeps track of important values for final score calculations
func track_stats():
	Global.goblins_killed = goblins_killed
	Global.player_health = $Player.health
	Global.waves = goblin_wave
