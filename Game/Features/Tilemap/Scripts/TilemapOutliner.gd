extends Node2D

@onready var Player = get_node("/root/Main/Player")
@onready var Tilemap = get_parent()
@onready var cell_size = Tilemap.tile_set.tile_size.x

func _process(delta):

	if Input.is_action_pressed("hang_and_float"):
		queue_redraw()
		show()
	else:
		# Remove drawings
		hide()

func _draw():

	if Input.is_action_pressed("hang_and_float"):

		for tile in Player.near_wall_tiles:
			tile = tile + Vector2(-1 * cell_size / 2,  -1 * cell_size / 2)
			draw_line(tile, tile + Vector2(0, cell_size), Color(255, 0, 0, 1))
			draw_line(tile, tile + Vector2(cell_size, 0), Color(255, 0, 0, 1))
			draw_line(tile + Vector2(0, cell_size), tile + Vector2(cell_size, cell_size), Color(255, 0, 0, 1))
			draw_line(tile + Vector2(cell_size, 0), tile + Vector2(cell_size, cell_size), Color(255, 0, 0, 1))

