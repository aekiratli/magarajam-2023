extends CharacterBody2D

@onready var Movement = get_node("Movement")
@onready var MapController = get_node("/root/Main/TileMap")
@onready var Resources : Node
@onready var Attributes : Node

var near_wall_tiles = []

func _ready():
	# set player position to starting point which is the center of the map
	position = MapController.get_starting_coordinates()

func _physics_process(delta):

	Movement.move_player(delta)
	move_and_slide()
