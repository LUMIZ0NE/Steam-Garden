extends Node2D
var sum_score = 0
#failsafe for if a user submits score without a username
var username = "Default Stanley"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Check for win condition on load, and determine a grade if true
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
	

func _process(delta):
	pass

func write_score_to_file():
	#verify if the file already exists and read_write to avoid overwriting previous contents if it does
	if FileAccess.file_exists("user://save_data.dat") == true:
		var file = FileAccess.open("user://save_data.dat", FileAccess.READ_WRITE)
		file.seek_end()
		file.store_string(username + " " + str(sum_score) + " " + $Grade.text + "\n")
	#if the file does not yet exist, creates it and applies the first score. No read as the file was not there to be read
	else:
		var file = FileAccess.open("user://save_data.dat", FileAccess.WRITE)
		file.seek_end()
		file.store_string(username + " " + str(sum_score) + " " + $Grade.text + "\n")

func _on_enter_score_pressed():
	#if text is not input, the username will default to the preset default to avoid nameless scores.
	if $NameInput.text != "":
		username = $NameInput.text
	print(username)
	$NameInput.hide()
	$EnterScore.hide()
	$ScoreSaver.show()
	write_score_to_file()
	
