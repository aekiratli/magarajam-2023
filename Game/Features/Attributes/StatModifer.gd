
class_name StatModifier

enum StatModType {
	Flat = 100,
	PercentAdd = 200,
	PercentMult = 300
}

var Value : float
var Type : StatModType
var Order : int
var Source : Variant

func _init(value: float, type: StatModType, source, order: int = -1) -> void:
	Value = value
	Type = type
	if	order == -1:
		order = type
	Order = order
	Source = source
