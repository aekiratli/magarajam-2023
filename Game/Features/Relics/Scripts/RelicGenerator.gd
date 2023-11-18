extends Node

@onready var MapController = get_node("../../TileMap")
@onready var RelicController = get_parent()
@onready var Relic = preload("res://Game/Features/Relics/Nodes/relic.tscn")
# create new instance of the Relic scene
@export var number_of_relics : int = 10

func _ready():
	var map = MapController.MapGenerator.map
	var width = MapController.width
	var height = MapController.height

	await get_tree().create_timer(0.000001).timeout
	var starting_area_coordinates = MapController.MapGenerator.starting_area_coordinates
	for i in range(RelicController.number_of_relics):
		# check if tile pos is valid
		var is_valid = false
		while !is_valid:
			var spawn_tile_pos = Vector2(randi() % width, randi() % height)
			var spawn_tile_index = spawn_tile_pos.x + spawn_tile_pos.y * width
			var is_in_starting_area = false

			for coords in starting_area_coordinates:
				if spawn_tile_pos.x == coords.x and spawn_tile_pos.y == coords.y:
					is_in_starting_area = true

			if map[spawn_tile_index] == 1 and not is_in_starting_area:
				is_valid = true
				var spawn_global_pos = MapController.map_to_local(spawn_tile_pos)
				RelicController.create_relic(spawn_global_pos)
