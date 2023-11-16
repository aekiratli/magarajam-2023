extends CharacterBody2D

@onready var PlayerMovement = get_node("PlayerMovement")

var near_wall_tiles = []

func _physics_process(delta):
	PlayerMovement.move_player(delta)
	move_and_slide()

