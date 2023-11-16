class_name Skill

signal leveled_up

var _level : Stat
var _learned : bool = false

func level_up():
	_level.set_base_value(_level.BaseValue + 1 )
	leveled_up.emit()
	
func get_level():
	return _level;
	
func Learn():
	_learned = true;
	
func is_learned():
	return _learned;
