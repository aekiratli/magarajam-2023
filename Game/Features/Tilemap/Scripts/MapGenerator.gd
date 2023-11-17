extends Node2D

@onready var NoiseGenerator = get_node("../NoiseGenerator")
@onready var MooreNeighboor = get_node("../MooreNeighboor")
@onready var MapController = get_parent()

@onready var noise_density : float = MapController.noise_density
@onready var width : int = MapController.width
@onready var height : int = MapController.height
@onready var iteration : int = MapController.iteration

@onready var starting_pattern = MapController.tile_set.get_pattern(1)
@onready var offset = Vector2i(width/2, height/2)

var map : Array = []
var starting_area_coordinates : Array = []
var _is_doors_open : bool = false

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

	MapController.set_pattern(0,offset, starting_pattern)

	for cell in starting_pattern.get_used_cells():
		var cell_pos = cell + offset
		starting_area_coordinates.append(cell_pos)
		# index for map array
		var index = cell_pos.x + cell_pos.y * width
		# update map as non minable
		map[index] = 1

func open_starting_area_doors():
	if _is_doors_open:
		return
	for cell in starting_pattern.get_used_cells():
		# do every 0.005 secs
		await get_tree().create_timer(0.005).timeout
		MapController.set_cell(0, cell + offset, 1, Vector2i(1,1))
	_is_doors_open = true