extends Node

@onready var MapController = get_node("../../TileMap")
@onready var RelicController = get_parent()

func _ready():
	var map = MapController.MapGenerator.map
	var width = MapController.width
	var height = MapController.height

	await get_tree().create_timer(0.1).timeout

	for i in range(RelicController.number_of_relics):
		# check if tile pos is valid
		var is_valid = false
		while !is_valid:
			var spawn_tile_pos = Vector2(randi() % width, randi() % height)
			var spawn_tile_index = spawn_tile_pos.x + spawn_tile_pos.y * width
			if map[spawn_tile_index] == 1:
				is_valid = true
				var spawn_global_pos = MapController.map_to_local(spawn_tile_pos)
				RelicController.create_relic(spawn_global_pos)