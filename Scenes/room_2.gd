extends Node2D
@onready var goblin_gate = $GoblinGate
signal gate_close
signal gate_open
const goblin = preload("res://scenes/goblin.tscn")
var goblins_killed = 0
var goblin_wave = 0

func _ready():
	if Global.room2_complete == true:
		$Goblin.queue_free()
		$GateCheck.queue_free()
		$GoblinGate.queue_free()
	goblin_gate.hide()

func _process(_delta):
	change_scene()
	gate_requirements_met()

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


func _on_gate_check_body_entered(body):
	if body.has_method("player"):
		goblin_gate.show()
		gate_close.emit()
		spawn_goblin()
		$GateCheck.queue_free()

func spawn_goblin():
	var spawnpoint = $SpawnPoints/Point1
	$Goblin.global_position = spawnpoint.global_position
	
func gate_requirements_met():
	if goblins_killed >= 1:
		gate_open.emit()


func _on_goblin_goblin_killed():
	goblins_killed = goblins_killed + 1
