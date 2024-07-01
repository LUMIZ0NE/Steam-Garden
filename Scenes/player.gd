extends CharacterBody2D
@onready var world = get_node('/root/World')
@export var speed = 200.0
@export var acceleration = 20
@export var friction = 10
@onready var player_sprite = $PlayerSprite
var direction = Vector2.ZERO

func player():
	pass

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
