extends Node2D

@onready var player = get_node("/root/Main/Player")
@onready var Tilemap = get_parent()
@onready var cell_size = Tilemap.tile_set.tile_size.x

var is_hang_and_float = false
var wall_tiles = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_hang_and_float = player.get_is_hang_and_float()
	if is_hang_and_float:
		wall_tiles = player.get_wall_tiles()
		queue_redraw()
		show()
	else:
		# Remove drawings
		hide()

func _draw():
	if is_hang_and_float:
		# Draw something
		#draw_circle(Vector2(timer,0), 100, Color(255, 255, 0, 1))
		for tile in wall_tiles:
			tile = tile + Vector2(-1 * cell_size / 2,  -1 * cell_size / 2)
			#draw_circle(tile, 10, Color(255, 255, 0, 1))
			draw_line(tile, tile + Vector2(0, cell_size), Color(255, 0, 0, 1))
			draw_line(tile, tile + Vector2(cell_size, 0), Color(255, 0, 0, 1))
			draw_line(tile + Vector2(0, cell_size), tile + Vector2(cell_size, cell_size), Color(255, 0, 0, 1))
			draw_line(tile + Vector2(cell_size, 0), tile + Vector2(cell_size, cell_size), Color(255, 0, 0, 1))
