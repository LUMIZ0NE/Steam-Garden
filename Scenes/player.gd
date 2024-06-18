extends CharacterBody2D

@onready var world = get_node('/root/World')
const SLASH = preload("res://Scenes/slash.tscn")
@export var speed = 200.0
@export var acceleration = 20
@export var friction = 10
@onready var player_sprite = $PlayerSprite
var direction = Vector2.ZERO

func _physics_process(delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		velocity = velocity.move_toward(direction * speed, acceleration)
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, friction)
	if velocity.x > 0:
		player_sprite.flip_h = true
	elif velocity.x < 0:
		player_sprite.flip_h = false

	move_and_slide()

func _input(event):
	if event.is_action_pressed("attack"):
		var slash = SLASH.instantiate()
		slash.global_position = global_position
		slash.rotate(direction.angle())
		world.add_child(slash)



