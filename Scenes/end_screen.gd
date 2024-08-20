extends Node2D
var sum_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.win_check == true:
		print("WIN!")
		$ResultBigText.text = "You collected goblin gem"
	else:
		print("loss")
		Global.player_health = 0
		$Grade.text = "Final grade: F"
	
	#display statistics for the run
	$GoblinKillCount.text = "Goblins killed: " + str(Global.goblins_killed)
	$HealthLeft.text = "Health remaining: " + str(Global.player_health)
	sum_score = Global.player_health / Global.goblins_killed * 5 
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
