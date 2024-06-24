extends Area2D
signal attack_used
@onready var slash_sprite = $SlashSprite
const PLAYER = preload("res://Scenes/player1.tscn")
var is_ready: bool = true

func _ready():
	translate(Vector2.RIGHT.rotated(rotation))
	hide()

func _process(_delta):
	
	if Input.is_action_just_pressed("attack") and is_ready:
		print("attack used")
		is_ready = false
		attack_used.emit()

func _on_slash_cooldown_timeout():
	print("attack ready")
	is_ready = true

func _on_slash_sprite_animation_finished():
	slash_sprite.queue_free()
