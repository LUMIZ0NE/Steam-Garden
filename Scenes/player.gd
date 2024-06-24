extends CharacterBody2D
@onready var slash_cooldown = $Slash/SlashCooldown
@onready var world = get_node('/root/World')
const SLASH = preload("res://Scenes/slash.tscn")
@export var speed = 200.0
@export var acceleration = 20
@export var friction = 10
@onready var player_sprite = $PlayerSprite
var direction = Vector2.ZERO
var offset = Vector2.ZERO

func _physics_process(_delta):
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

func find_direction_x():
	if direction.x > 0:
		offset = Vector2(40,0)
	elif direction.x < 0:
		offset = Vector2(-40,0)

func find_direction_y():
	if direction.y > 0:
		offset = Vector2(0,40)
	elif direction.y < 0:
		offset = Vector2(0,-40)

func _on_slash_attack_used():
	print("test")
	var slash = SLASH.instantiate()
	find_direction_x()
	find_direction_y()
	slash.global_position = global_position + offset
	slash.rotate(direction.angle())
	world.add_child(slash)
	slash.show()
	$Slash/SlashCooldown.start()

