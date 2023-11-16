extends Node2D

@onready var Player = get_parent()
@onready var MapController = get_node("/root/Main/TileMap")

var timer = 0
var angle = 0

func move_player(_delta):
	# Calculate moving direction
	var mouse_pos = get_global_mouse_position()
	var move_direction = mouse_pos - get_global_position()

	# Calculate the angle between player and mouse
	angle = move_direction.angle()
	angle = lerp_angle(Player.rotation, angle, 0.1)
	
	# Rotate Player
	Player.rotation = angle

	# Space is defined in project settings
	if Input.is_action_pressed("hang_and_float"):

		# If space is pressed float the player up and down like a wave
		timer += _delta * 7
		Player.position.y += sin(timer) / 2

		# Update wall tiles near player
		var tile_pos = MapController.local_to_map(Player.position)
		Player.near_wall_tiles = MapController.get_wall_tiles_near_global_position(4,tile_pos)
		return

	# Use smooth movement with interpolation
	# Update player position
	Player.position = Player.position.lerp(mouse_pos, 0.01)
