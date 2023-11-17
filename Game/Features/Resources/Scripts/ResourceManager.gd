extends Node

@onready var Relic: GameResource = GameResource.new()
@onready var Scrap: GameResource = GameResource.new()
@onready var RuneStone: GameResource = GameResource.new()

func _ready():
	GameContext.Player.Resources = self
	GameManager.game_started.connect(on_game_started)
	Relic.set_amount(0)
	Scrap.set_amount(0)
	RuneStone.set_amount(0)
	
func on_game_started():
	Scrap.set_amount(0)

func save():
	var save_dict = {
		"relic" : Relic.get_amount(),
		"scrap" : Scrap.get_amount(),
		"runeStone" : RuneStone.get_amount()
	}
	return save_dict
