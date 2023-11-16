extends TileMap

@export var noise_density : float = 0.60
@export var width : int = 100
@export var height : int = 100
@export var iteration : int = 10

const CELL_LOCATION = {
	CORNER_TOP_LEFT = 0,
	CORNER_TOP_RIGHT = 1,
	CORNER_BOTTOM_LEFT = 2,
	CORNER_BOTTOM_RIGHT = 3,
	TOP_BORDER = 4,
	RIGHT_BORDER = 5,
	BOTTOM_BORDER = 6,
	LEFT_BORDER = 7,
	INSIDE = 8
}

# private variables to store grid
var grid = []
var moore_grid = []

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_noise()
	moore_neighboor()
	visualize_grid(moore_grid)

func generate_noise(_visualize = false):
	for x in range(width):
		for y in range(height):
			# generate random value between 0 and 1
			var noise = randf()
			# if the noise value is greater than density
			if noise >= noise_density:
				# set the value to 1
				noise = 1
			else:
				# set the value to 0
				noise = 0
			grid.append(noise)
	if _visualize:
		visualize_grid(grid)

func moore_neighboor():

	for i in range(iteration):
		var _tmp_grid = []
		for cell in range(len(grid)):
			var _number_of_zeros = 0
			var _is_default_zero = true
			var _indexes = []
			# check if it is corner
			if cell == 0:
				_number_of_zeros = _number_of_zeros + 5
				_indexes = get_cell_neighboors_index(cell, CELL_LOCATION.CORNER_TOP_LEFT)
			elif cell == width - 1:
				_number_of_zeros = _number_of_zeros + 5
				_indexes = get_cell_neighboors_index(cell, CELL_LOCATION.CORNER_TOP_RIGHT)
			elif cell == width * height - 1:
				_number_of_zeros = _number_of_zeros + 5
				_indexes = get_cell_neighboors_index(cell, CELL_LOCATION.CORNER_BOTTOM_RIGHT)
			elif cell == width * height - width:
				_number_of_zeros = _number_of_zeros + 5
				_indexes = get_cell_neighboors_index(cell, CELL_LOCATION.CORNER_BOTTOM_LEFT)
			# check if it is border
			elif 0 < cell and cell < width - 1:
				_number_of_zeros = _number_of_zeros + 3
				_indexes = get_cell_neighboors_index(cell, CELL_LOCATION.TOP_BORDER)
			elif width * height - width < cell and cell < width * height - 1:
				_number_of_zeros = _number_of_zeros + 3
				_indexes = get_cell_neighboors_index(cell, CELL_LOCATION.BOTTOM_BORDER)
			elif cell % width == 0:
				_number_of_zeros = _number_of_zeros + 3
				_indexes = get_cell_neighboors_index(cell, CELL_LOCATION.LEFT_BORDER)
			elif (cell + 1) % width == 0:
				_number_of_zeros = _number_of_zeros + 3
				_indexes = get_cell_neighboors_index(cell, CELL_LOCATION.RIGHT_BORDER)
			else: # inside the grid
				_indexes = get_cell_neighboors_index(cell, CELL_LOCATION.INSIDE)
				_is_default_zero = false

			for index in _indexes:
				var _value = get_index_value(index)
				if _value == 0:
					_number_of_zeros = _number_of_zeros + 1
			if _number_of_zeros > 4 or _is_default_zero:
				_tmp_grid.append(0)
			else:
				_tmp_grid.append(1)
		grid = _tmp_grid
	moore_grid = grid

func get_cell_neighboors_index(index, location):
	var neighboor_indexes = []
	if location == CELL_LOCATION.CORNER_TOP_LEFT:
		neighboor_indexes.append(index + 1)
		neighboor_indexes.append(index + width)
		neighboor_indexes.append(index + width + 1)
	elif location == CELL_LOCATION.CORNER_TOP_RIGHT:
		neighboor_indexes.append(index - 1)
		neighboor_indexes.append(index + width)
		neighboor_indexes.append(index + width - 1)
	elif location == CELL_LOCATION.CORNER_BOTTOM_LEFT:
		neighboor_indexes.append(index + 1)
		neighboor_indexes.append(index - width)
		neighboor_indexes.append(index - width + 1)
	elif location == CELL_LOCATION.CORNER_BOTTOM_RIGHT:
		neighboor_indexes.append(index - 1)
		neighboor_indexes.append(index - width)
		neighboor_indexes.append(index - width - 1)
	elif location == CELL_LOCATION.TOP_BORDER:
		neighboor_indexes.append(index - 1)
		neighboor_indexes.append(index + 1)
		neighboor_indexes.append(index + width)
	elif location == CELL_LOCATION.RIGHT_BORDER:
		neighboor_indexes.append(index - width)
		neighboor_indexes.append(index + width)
		neighboor_indexes.append(index - 1)
	elif location == CELL_LOCATION.BOTTOM_BORDER:
		neighboor_indexes.append(index - 1)
		neighboor_indexes.append(index + 1)
		neighboor_indexes.append(index - width)
	elif location == CELL_LOCATION.LEFT_BORDER:
		neighboor_indexes.append(index - width)
		neighboor_indexes.append(index + width)
		neighboor_indexes.append(index + 1)
	# inside the grid
	else:
		neighboor_indexes.append(index - width - 1)
		neighboor_indexes.append(index - width)
		neighboor_indexes.append(index - width + 1)
		neighboor_indexes.append(index - 1)
		neighboor_indexes.append(index + 1)
		neighboor_indexes.append(index + width - 1)
		neighboor_indexes.append(index + width)
		neighboor_indexes.append(index + width + 1)
	return neighboor_indexes

func get_index_value(index):
	return grid[index]
func get_moore_index_value(index):
	return moore_grid[index]
	
func visualize_grid(_grid):
	for cell in range(len(_grid)):
		var x = cell % width
		var y = cell / width
		if get_moore_index_value(cell) == 0:
			set_cell(0, Vector2i(x,y), 1, Vector2i(0,1))
		else:
			set_cell(0, Vector2i(x,y), 1, Vector2i(1,1))

func get_wall_tiles_in_radius(radius: int, position: Vector2i):
	var wall_positions = []
	for x in range(-radius, radius):
		for y in range(-radius, radius):
			var check_pos = position + Vector2i(x, y)
			# calculate index for moore grid
			var index = check_pos.x + check_pos.y * width
			print(index)
			if get_moore_index_value(index) == 0 and index > 0:
				var _global_position = map_to_local(check_pos)
				wall_positions.append(_global_position)
		
	return wall_positions
