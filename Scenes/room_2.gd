extends Node2D
@onready var goblin_gate = $GoblinGate
signal gate_close

func _ready():
	goblin_gate.hide()

func _process(_delta):
	change_scene()

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
		$GateCheck.queue_free()
