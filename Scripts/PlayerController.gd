extends CharacterBody2D

@export var speed = 200
@export var rotation_speed = 200
var timer = 0
var is_hang_and_float = false
var angle = 0
var wall_tiles = []
var mining_position = Vector2()
@onready var tilemap = get_node("../TileMap")
@onready var cell_size = tilemap.tile_set.tile_size

func _physics_process(delta):
	# Get direction
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - get_global_position()

	# Calculate the angle between player and mouse
	angle = direction.angle()
	angle = lerp_angle(rotation, angle, 0.1)
	rotation = angle

	if Input.is_action_pressed("hang_and_float"):
		# If space is pressed float the player up and down like a wave
		timer += delta * 7
		is_hang_and_float = true
		position.y += sin(timer) / 2
		# get player position in tilemap
		var tile_pos = tilemap.local_to_map(mining_position)
		wall_tiles = tilemap.get_wall_tiles_in_radius(4,tile_pos)
		return
	# Use smooth movement with interpolation
	position = position.lerp(mouse_pos, 0.01)
	mining_position = Vector2(position.x, position.y)
	wall_tiles = []
	# Update player position
	timer = 0
	is_hang_and_float = false
	move_and_slide()

# Public func to get the angle
func get_angle():
	return angle
# Public func to get is_hang_and_float
func get_is_hang_and_float():
	return is_hang_and_float
# Public func to get wall_tiles
func get_wall_tiles():
	return wall_tiles