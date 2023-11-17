extends Node

signal game_started
signal game_over

func StartGame():
	game_started.emit()
	
func EndGame(success: bool):
	game_over.emit(success)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()

