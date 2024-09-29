extends Node2D
var sum_score = 0
var username = "Default Stanley"
# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.win_check == true:
		print("WIN!")
		$ResultBigText.text = "You collected goblin gem"
		$NameInput.visible = true
		$EnterScore.visible = true
		sum_score = Global.player_health / Global.goblins_killed * 5
	else:
		print("loss")
		Global.player_health = 0
		$Grade.text = "Final grade: F"
		$NameInput.visible = false
		$EnterScore.visible = false
	
	#display statistics for the run
	$GoblinKillCount.text = "Goblins killed: " + str(Global.goblins_killed)
	$HealthLeft.text = "Health remaining: " + str(Global.player_health)
	print(str(sum_score))
	if sum_score == 0:
		$Grade.text = "Final grade: F"
	if sum_score >= 60:
		$Grade.text = "Final grade: D"
	if sum_score >= 130:
		$Grade.text = "Final grade: C"
	if sum_score >= 175:
		$Grade.text = "Final grade: B" 
	if sum_score >= 250:
		$Grade.text = "Final grade: A"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func write_score_to_file():
	var file = FileAccess.open("user://save_data.dat", FileAccess.READ)
	if file.file_exists("user://save_data.dat"):
		file = FileAccess.open("user://save_data.dat", FileAccess.READ_WRITE)
		file.seek_end()
		file.store_string(username + " " + str(sum_score) + " " + $Grade.text + "\n")

func _on_enter_score_pressed():
	if $NameInput.text != "":
		username = $NameInput.text
	print(username)
	$NameInput.hide()
	$EnterScore.hide()
	write_score_to_file()
	
