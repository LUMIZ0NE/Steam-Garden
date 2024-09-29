extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ScoreDisplay.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/world1.tscn")


func _on_score_view_pressed():
	var file = FileAccess.open("user://save_data.dat", FileAccess.READ)
	var score_history = file.get_as_text()
	if $ScoreDisplay.visible == false:
		$ScoreView.text = "Hide Scores"
		$ScoreDisplay.text = score_history
		$ScoreDisplay.show()
		$ScoreTitle.show()
	else:
		$ScoreView.text = "View Scores"
		$ScoreDisplay.hide()
		$ScoreTitle.hide()
