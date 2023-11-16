extends Node

signal game_started
signal game_over

func StartGame():
	game_started.emit()
	
func EndGame(success: bool):
	game_over.emit(success)
