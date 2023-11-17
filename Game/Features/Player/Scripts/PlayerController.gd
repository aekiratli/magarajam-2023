extends CharacterBody2D

@onready var Movement = get_node("Movement")
@onready var Attributes = get_node("Attributes")
@onready var Resources = get_node("Resources")
@onready var MapController = get_node("/root/Main/TileMap")

var near_wall_tiles = []

func _ready():
	# set player position to starting point which is the center of the map
	position = MapController.get_starting_coordinates()

func _physics_process(delta):

	Movement.move_player(delta)
	move_and_slide()

func save():
	var save_dict = Attributes.save()
	var save_dict2 = Resources.save()
	for data in save_dict2:
		save_dict[data] = save_dict2[data]
	
