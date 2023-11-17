class_name Skill

const StatModifier = preload("res://Game/Features/Attributes/StatModifer.gd")

signal leveled_up

var _level : Stat
var _effectiveness : Stat
var _learned : bool = false

func _ready():
	GameContext.Player.Resources.Scrap.amount_updated.connect(on_scrap_amount_updated)

func level_up():
	_level.set_base_value(_level.BaseValue + 1 )
	leveled_up.emit()
	
func get_level():
	return _level;
	
func Learn():
	_learned = true;
	
func is_learned():
	return _learned;

func get_effectiveness():
	return _effectiveness._value;
	
func on_scrap_amount_updated():
	_effectiveness.remove_all_modifiers_from_source("scrap")
	var newModifier = StatModifier.new(GameContext.Player.Resources.Scrap.get_amount(), StatModifier.StatModType.PercentAdd, "scrap");
	_effectiveness.add_modifier(newModifier)
