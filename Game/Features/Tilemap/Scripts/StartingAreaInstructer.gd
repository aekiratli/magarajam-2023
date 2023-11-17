extends Node

@onready var StartingAreaInstructer = get_node("../Label")
@onready var MapController = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	var starting_coordinates = MapController.get_starting_coordinates()
	# move label to starting coordinates
	StartingAreaInstructer.position = starting_coordinates


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
