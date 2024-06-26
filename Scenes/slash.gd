extends Area2D
@onready var slash_sprite = $SlashSprite
@onready var slash_cooldown = $SlashCooldown
const PLAYER = preload("res://Scenes/player1.tscn")
var is_ready: bool = true
signal attack_used


func _ready():
	translate(Vector2.RIGHT.rotated(rotation))
	hide()

func _process(delta):
	if Input.is_action_just_pressed("attack") and is_ready:
		print("attack used")
		is_ready = false
		attack_used.emit()

func _on_slash_cooldown_timeout():
	print("attack ready")
	is_ready = true

func _on_slash_sprite_animation_finished():
	slash_sprite.queue_free()

