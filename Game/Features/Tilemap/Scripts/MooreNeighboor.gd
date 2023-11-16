extends Node2D

# Enum for cell locations
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

func get_array_index_value(noise_array: Array, index: int) -> int:
	return noise_array[index]

func generate_moore_neighboor(iteration: int, width: int, height: int, noise_array: Array) -> Array:

	for i in range(iteration):
		var _tmp_grid = []
		for cell in range(len(noise_array)):
			var _number_of_walls = 0
			var _is_cell_zero = true
			var _cell_neighboor_indexes = []
			# check if it is corner
			if cell == 0:
				_number_of_walls = _number_of_walls + 5
				_cell_neighboor_indexes = get_cell_neighboors_indexex(width, cell, CELL_LOCATION.CORNER_TOP_LEFT)
			elif cell == width - 1:
				_number_of_walls = _number_of_walls + 5
				_cell_neighboor_indexes = get_cell_neighboors_indexex(width, cell, CELL_LOCATION.CORNER_TOP_RIGHT)
			elif cell == width * height - 1:
				_number_of_walls = _number_of_walls + 5
				_cell_neighboor_indexes = get_cell_neighboors_indexex(width, cell, CELL_LOCATION.CORNER_BOTTOM_RIGHT)
			elif cell == width * height - width:
				_number_of_walls = _number_of_walls + 5
				_cell_neighboor_indexes = get_cell_neighboors_indexex(width, cell, CELL_LOCATION.CORNER_BOTTOM_LEFT)
			# check if it is border
			elif 0 < cell and cell < width - 1:
				_number_of_walls = _number_of_walls + 3
				_cell_neighboor_indexes = get_cell_neighboors_indexex(width, cell, CELL_LOCATION.TOP_BORDER)
			elif width * height - width < cell and cell < width * height - 1:
				_number_of_walls = _number_of_walls + 3
				_cell_neighboor_indexes = get_cell_neighboors_indexex(width, cell, CELL_LOCATION.BOTTOM_BORDER)
			elif cell % width == 0:
				_number_of_walls = _number_of_walls + 3
				_cell_neighboor_indexes = get_cell_neighboors_indexex(width, cell, CELL_LOCATION.LEFT_BORDER)
			elif (cell + 1) % width == 0:
				_number_of_walls = _number_of_walls + 3
				_cell_neighboor_indexes = get_cell_neighboors_indexex(width, cell, CELL_LOCATION.RIGHT_BORDER)
			else: # inside the grid
				_cell_neighboor_indexes = get_cell_neighboors_indexex(width, cell, CELL_LOCATION.INSIDE)
				_is_cell_zero = false

			for index in _cell_neighboor_indexes:
				var _value = get_array_index_value(noise_array, index)
				if _value == 0:
					_number_of_walls = _number_of_walls + 1
			if _number_of_walls > 4 or _is_cell_zero:
				_tmp_grid.append(0)
			else:
				_tmp_grid.append(1)
		noise_array = _tmp_grid
	return noise_array

func get_cell_neighboors_indexex(width, index: int, location: int) -> Array:

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

