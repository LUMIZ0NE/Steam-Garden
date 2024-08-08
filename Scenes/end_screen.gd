extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.win_check == true:
		print("WIN!")
		$ResultBigText.text = "You collected goblin gem"
	else:
		print("loss")
	
	#display statistics for the run
	$GoblinKillCount.text = "Goblins killed: " + str(Global.goblins_killed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
