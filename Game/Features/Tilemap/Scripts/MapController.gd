extends TileMap

@onready var MapGenerator = get_node("MapGenerator")
@onready var StartingAreaInstructer = get_node("Label")

@export var noise_density : float = 0.60
@export var width : int = 100
@export var height : int = 100
@export var iteration : int = 10

func _ready():
	MapGenerator.generate_map()
	MapGenerator.generate_starting_area()

func _process(delta):

	if Input.is_action_pressed("explore"):
		MapGenerator.open_starting_area_doors()
		# hide instructions
		StartingAreaInstructer.visible = false


func get_wall_tiles_near_global_position(radius: int, position: Vector2i):

	var wall_positions = []

	for x in range(-radius, radius):
		for y in range(-radius, radius):

			var check_pos = position + Vector2i(x, y)
			# calculate index for moore grid
			var index = check_pos.x + check_pos.y * width
			# maximum index
			if index > width * height:
				return
			# 0 means wall
			if MapGenerator.map[index] == 0 and index > 0:
				var _global_position = map_to_local(check_pos)
				wall_positions.append(_global_position)

			if MapGenerator.map[index] == 0 and index > 0:
				var _global_position = map_to_local(check_pos)
				wall_positions.append(_global_position)
	return wall_positions

func get_starting_coordinates():

	return map_to_local(Vector2i(height / 2 + 5 , width / 2 + 5))
