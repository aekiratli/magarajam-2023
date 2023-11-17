class_name Stat

signal value_updated

var BaseValue : float
var _is_dirty : bool = true
var _last_base_value : float
var _value : float
var _stat_modifiers : Array
var _StatModifiers : Array

func _init() -> void:
	_stat_modifiers = []
	_StatModifiers = _stat_modifiers
	
func init(base_value: float) -> void:
	self._init()
	BaseValue = base_value
	
func set_base_value(value: float) -> void:
	BaseValue = value
	value_updated.emit()
	
func get_value():
	if _is_dirty || _last_base_value != BaseValue:
		_last_base_value = BaseValue;
		_value = calculate_final_value();
		_is_dirty = false;
	return _value;
	
func add_modifier(mod: StatModifier) -> void:
	_is_dirty = true
	_stat_modifiers.append(mod)
	value_updated.emit()
	
func remove_modifier(mod: StatModifier) -> bool:
	if _stat_modifiers.has(mod):
		_stat_modifiers.erase(mod)
		_is_dirty = true
		value_updated.emit()
		return true
	value_updated.emit()
	return false
	
func remove_all_modifiers_from_source(source) -> bool:
	var num_removals = 0
	for i in range(_stat_modifiers.size()):
		var mod = _stat_modifiers[i]
		if mod.Source == source:
			_stat_modifiers.remove_at(i)
			i -= 1  # Adjust the index after removal
			num_removals += 1
	if num_removals > 0:
		_is_dirty = true
		value_updated.emit()
		return true
	value_updated.emit()
	return false
	
func remote_condition(a: Object, b: Object) -> bool:
	if	a == b:
		return true
	return false
	
func compare_modifier_order(a: StatModifier, b: StatModifier) -> int:
	if a.Order < b.Order:
		return -1
	elif a.Order > b.Order:
		return 1
	return 0
	
func calculate_final_value() -> float:
	var _final_value : float = BaseValue
	var sum_percent_add : float = 0
	_stat_modifiers.sort_custom(compare_modifier_order)
	for i in range(_stat_modifiers.size()):
		var mod : StatModifier = _stat_modifiers[i]
		if mod.Type == StatModifier.StatModType.Flat:
			_final_value += mod.Value
		elif mod.Type == StatModifier.StatModType.PercentAdd:
			sum_percent_add += mod.Value
			if i + 1 >= _stat_modifiers.size() or _stat_modifiers[i + 1].Type != StatModifier.StatModType.PercentAdd:
				_final_value *= 1 + sum_percent_add
				sum_percent_add = 0
		elif mod.Type == StatModifier.StatModType.PercentMult:
			_final_value *= 1 + mod.Value
		# Workaround for float calculation errors, like displaying 12.00001 instead of 12
	return round(_final_value)
