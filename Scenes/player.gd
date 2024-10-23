extends CharacterBody2D
# set variables on player's first load
@export var speed = 200.0
@export var acceleration = 20
@export var friction = 10
@onready var player_sprite = $PlayerSprite
var direction = Vector2.ZERO
var current_direction = "none"
var enemy_inrange = false
var enemy_atk_cooldown = true
var health = 200
var player_alive = true

#here for goblin's attacks
signal goblin_stab
signal goblin_stop
var attack_ip = false

func player():
	pass

func _physics_process(_delta):
	player_movement(_delta)
	enemy_attack()
	attack()
	
	# Send player to end screen with win conditions not met once health reaches at or below 0
	if health <= 0:
		player_alive = false
		health = 0
		print("you should be dead")
		get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")

# player directional movement and respective animations
func player_movement(delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		velocity = velocity.move_toward(direction * speed, acceleration)
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	if velocity.x > 0:
		current_direction = "Left"
		play_anim(1)
	elif velocity.x < 0:
		current_direction = "Right"
		play_anim(1)
	else:
		play_anim(0)
	if velocity.y > 0:
		current_direction = "Down"
		play_anim(1)
	elif velocity.y < 0:
		current_direction = "Up"
		play_anim(1)
	
	move_and_slide()

# check if goblin(s) are in range to attack
func _on_player_hitbox_body_entered(body):
	if body.has_method("goblin"):
		enemy_inrange = true

# check if goblin(s) are out of range
func _on_player_hitbox_body_exited(body):
	if body.has_method("goblin"):
		enemy_inrange = false

# take damage when goblin attacks 
func enemy_attack():
	if enemy_inrange and enemy_atk_cooldown == true:
		health = health - 10
		enemy_atk_cooldown = false
		$AtkCooldown.start()
		print(health)
		goblin_stab.emit()
		

func _on_atk_cooldown_timeout():
	enemy_atk_cooldown = true
	goblin_stop.emit()

# determine if the player is moving and in what direction to set correct animations
func play_anim(moving):
	var dir = current_direction
	var anim = $PlayerSprite
	if moving == 1:
		if dir == "Right":
			player_sprite.flip_h = true
			if attack_ip == false:
				anim.play("siderun")
		elif dir == "Left":
			player_sprite.flip_h = false
			if attack_ip == false:
				anim.play("siderun")
		if dir == "Up":
			if attack_ip == false:
				anim.play("green")
		elif dir == "Down":
			if attack_ip == false:
				anim.play("green")
	elif moving == 0:
		if attack_ip == false:
			anim.play("idle")

# determine when attack key is pressed and set cooldown and animation accordingly
func attack():
	var dir2 = current_direction
	if Input.is_action_just_pressed("attack"):
		print("attacked")
		Global.player_current_atk = true
		attack_ip = true
		if dir2 == "Right":
			$PlayerSprite.flip_h = true
			$PlayerSprite.play("blue")
			$PlayerCooldown.start()
		elif dir2 == "Left":
			$PlayerSprite.flip_h = false
			$PlayerSprite.play("blue")
			$PlayerCooldown.start()
		if dir2 == "Up":
			$PlayerSprite.play("orange")
			$PlayerCooldown.start()
		elif dir2 == "Down":
			$PlayerSprite.play("orange")
			$PlayerCooldown.start()

# cooldown ends on player attack
func _on_player_cooldown_timeout():
	$PlayerCooldown.stop()
	Global.player_current_atk = false
	attack_ip = false
