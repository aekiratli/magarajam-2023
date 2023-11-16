extends TileMap

@export var width : int = 100
@export var height : int = 100
# define public 2d starting point
@export var starting_point : Vector2i
@export var iteration : int = 3
@export var time_smoothness : float = 0.05

var is_init_finished = false
var timer: float = 0.0
var current_iteration = 0
var current_position

# Called when the node enters the scene tree for the first time.
func _ready():
	current_position = starting_point
	generate_base_map()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer >= time_smoothness:
		if current_iteration < iteration:
			set_cell(0, current_position, 0, Vector2i(1,1))
			walk(current_iteration)
			timer = 0
			current_iteration += 1

func generate_base_map():
	for x in width:
		for y in height:
			set_cell(0, Vector2i(x,y), 0, Vector2i(0,1))
	# place starting point
	set_cell(0, starting_point, 0, Vector2i(1,1))

func get_available_directions():
	var directions = []
	if current_position.x > 0:
		directions.append(Vector2i(-1,0))
	if current_position.x < width:
		directions.append(Vector2i(1,0))
	if current_position.y > 0:
		directions.append(Vector2i(0,-1))
	if current_position.y < height:
		directions.append(Vector2i(0,1))
	return directions

func walk(_iteration):
	var directions = get_available_directions()
	var direction = directions[randi() % directions.size()]
	current_position += direction
	# if current position is out of maps bounds, reset to starting point
	if current_position.x < 0 or current_position.x > width or current_position.y < 0 or current_position.y > height:
		current_position = current_position - direction * 5
	# place a placeholder for the current position
	set_cell(0, current_position, 1, Vector2i(0,0))
	if _iteration == iteration - 1:
		set_cell(0, current_position, 0, Vector2i(1,1))
