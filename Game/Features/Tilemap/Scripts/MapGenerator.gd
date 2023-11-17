extends Node2D

@onready var NoiseGenerator = get_node("../NoiseGenerator")
@onready var MooreNeighboor = get_node("../MooreNeighboor")
@onready var MapController = get_parent()

@onready var noise_density : float = MapController.noise_density
@onready var width : int = MapController.width
@onready var height : int = MapController.height
@onready var iteration : int = MapController.iteration

var map : Array = []

func generate_map():

	var _noise_array = NoiseGenerator.generate_noise(width, height, noise_density)
	for cell in range(len(_noise_array)):
		var x = cell % width
		var y = cell / width
		if _noise_array[cell] == 0:
			MapController.set_cell(0, Vector2i(x,y), 1, Vector2i(0,1))
		else:
			MapController.set_cell(0, Vector2i(x,y), 1, Vector2i(1,1))

	var _moore_array = MooreNeighboor.generate_moore_neighboor(iteration, width, height, _noise_array)
	map = _moore_array
	for cell in range(len(_moore_array)):
		var x = cell % width
		var y = cell / width
		if _moore_array[cell] == 0:
			MapController.set_cell(0, Vector2i(x,y), 1, Vector2i(0,1))
		else:
			MapController.set_cell(0, Vector2i(x,y), 1, Vector2i(1,1))

func generate_starting_area():

	var starting_pattern = MapController.tile_set.get_pattern(1)
	starting_pattern.get_used_cells( )
	MapController.set_pattern(0,Vector2i(width/2, height/2), starting_pattern)
