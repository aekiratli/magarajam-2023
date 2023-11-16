
class_name StatModifier

enum StatModType {
	Flat = 100,
	PercentAdd = 200,
	PercentMult = 300
}

var Value : float
var Type : StatModType
var Order : int
var Source : Object

func _init(value: float, type: StatModType, order: int = -1, source: Object = null) -> void:
	Value = value
	Type = type
	if	order == -1:
		order = type
	Order = order
	Source = source
