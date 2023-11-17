extends Node

@onready var Player
@onready var Tilemap

func _ready():
	var tree = get_tree()
	var root = tree.get_root()
	var main = root.get_node("Main")
	Player = main.get_node("Player")
	Tilemap = main.get_node("Tilemap")
