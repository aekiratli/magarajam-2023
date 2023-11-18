class_name Skill

signal leveled_up

var _level : Stat = Stat.new()
var _effectiveness : Stat = Stat.new()
var _learned : bool = false

func _ready():
	_level.set_base_value(0)
	_effectiveness.set_base_value(0)

func level_up():
	_level.set_base_value(_level.BaseValue + 1 )
	leveled_up.emit()
	
func set_level(val):
	_level.set_base_value(val)
	
func get_level():
	return _level;
	
func Learn():
	_learned = true;
	
func is_learned():
	return _learned;

func get_effectiveness():
	return _effectiveness._value;
