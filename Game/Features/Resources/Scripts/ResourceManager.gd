extends Node

class_name ResourceManager

@onready var GameManager = get_node("/root/GameManager")

var Relic: GameResource
var Scrap: GameResource
var RuneStone: GameResource

func _ready():
	connect("game_started",on_game_started())
	
func on_game_started():
	Scrap.set_amount(0)
