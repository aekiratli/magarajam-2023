class_name GameResource

signal amount_updated

var _amount : float
	
func set_amount(value: float) -> void:
	_amount = value
	amount_updated.emit()

func get_amount():
	return _amount

func gain(value: float):
	set_amount(_amount + value)

func spend(value: float):
	set_amount(_amount - value)
