extends Node

@onready var Relic: GameResource
@onready var Scrap: GameResource
@onready var RuneStone: GameResource

func _ready():
	GameManager.game_started.connect(on_game_started)
	
func on_game_started():
	Scrap.set_amount(0)

func save():
	var save_dict = {
		"relic" : Relic.get_amount(),
		"scrap" : Scrap.get_amount(),
		"runeStone" : RuneStone.get_amount()
	}
	return save_dict
