
class_name UpgradableStat extends Stat

var _baseModifier : StatModifier
var _level : int

func set_level_up_modifier(mod : StatModifier):
	_baseModifier = mod
	
func level_up():
	add_modifier(_baseModifier)
	_level += 1;
	
func set_level(val : int):
	for n in val:
		level_up()
