extends CharacterBody2D
signal goblin_killed

const speed = 140
@onready var sprite = $Sprite
@onready var player = get_tree().get_first_node_in_group("Player")

var health = 80
var player_inrange = false
var can_hurt = true
var goblin_alive = true
var goblin_attacking = false
# Called when the node enters the scene tree for the first time.
func _ready():
	# ensure variables are set correctly when the goblin is called
	goblin_alive = true
	goblin_attacking = false
	can_hurt = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Prevent goblin from moving freely while in an attack animation
	if goblin_alive == true:
		if goblin_attacking == false:
			goblin_move()
		damages()

# Goblin moves toward the player position
func goblin_move():
	var direction_to_player = global_position.direction_to(player.global_position)
	velocity = direction_to_player * speed
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	move_and_slide()
	
# verifies goblin-ness of the goblin
func goblin():
	pass

# hit/hurtboxes for the goblin to determine if the player is within attacking range
func _on_goblin_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inrange = true

func _on_goblin_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inrange = false

# if all necessary variables are correct, goblin takes damage and activates an immunity cooldown
func damages():
	if player_inrange and Global.player_current_atk and can_hurt == true:
		health = health - 20
		print("goblin took damag")
		can_hurt = false
		$GoblinOuch.start()
		if health <= 0:
			$Sprite.play("die")
			goblin_alive = false
			$GoblinDies.start()
	elif can_hurt == false:
		print("goblin cant be hit rn sorry bub")

# play attack animation when goblin atatcks
func _on_player_goblin_stab():
	if goblin_alive == true:
		goblin_attacking = true
		$Sprite.play("attack")


# stop attack animation
func _on_player_goblin_stop():
	if goblin_alive == true:
		goblin_attacking = false
		$Sprite.play("default")

# re-enables goblin's ability to take damage once cooldown ends
func _on_goblin_ouch_timeout():
	can_hurt = true

# remove goblin on death
func _on_goblin_dies_timeout():
	goblin_killed.emit()
	self.queue_free()

# set goblin variables to false to avoid interference with other goblins
func _on_goblin_killed():
	goblin_attacking = false
	player_inrange = false
	
