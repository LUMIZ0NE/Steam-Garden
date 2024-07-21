extends CharacterBody2D
@export var speed = 200.0
@export var acceleration = 20
@export var friction = 10
@onready var player_sprite = $PlayerSprite
var direction = Vector2.ZERO

var enemy_inrange = false
var enemy_atk_cooldown = true
var health = 100
var player_alive = true

var attack_ip = false

func player():
	pass

func _physics_process(_delta):
	player_movement(_delta)
	enemy_attack()
	
	if health <= 0:
		player_alive = false
		health = 0
		print("you should be dead")

func player_movement(delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		velocity = velocity.move_toward(direction * speed, acceleration)
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	if velocity.x > 0:
		player_sprite.flip_h = false
	elif velocity.x < 0:
		player_sprite.flip_h = true
	move_and_slide()

func _on_player_hitbox_body_entered(body):
	if body.has_method("goblin"):
		enemy_inrange = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("goblin"):
		enemy_inrange = false

func enemy_attack():
	if enemy_inrange and enemy_atk_cooldown == true:
		health = health - 10
		enemy_atk_cooldown = false
		$AtkCooldown.start()
		print(health)


func _on_atk_cooldown_timeout():
	enemy_atk_cooldown = true
