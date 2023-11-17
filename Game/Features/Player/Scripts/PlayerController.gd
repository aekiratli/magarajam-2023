extends CharacterBody2D

@onready var Movement = get_node("Movement")
@onready var Resources : Node
@onready var Attributes : Node

var near_wall_tiles = []

func _physics_process(delta):
	Movement.move_player(delta)
	move_and_slide()
