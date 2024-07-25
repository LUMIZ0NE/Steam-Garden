extends CharacterBody2D

const speed = 140
@onready var sprite = $Sprite
@onready var player = get_tree().get_first_node_in_group("Player")

var health = 80
var player_inrange = false
var can_hurt = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	goblin_move()
	damages()

func goblin_move():
	var direction_to_player = global_position.direction_to(player.global_position)
	velocity = direction_to_player * speed
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	move_and_slide()
	
func goblin():
	pass

func _on_goblin_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inrange = true

func _on_goblin_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inrange = false

func damages():
	if player_inrange and Global.player_current_atk and can_hurt == true:
		health = health - 20
		print("goblin took damag")
		$GoblinOuch.start()
		can_hurt = false
		if health <= 0:
			self.queue_free()


func _on_player_goblin_stab():
	$Sprite.play("attack")



func _on_player_goblin_stop():
	$Sprite.play("default")


func _on_goblin_ouch_timeout():
	can_hurt = true
