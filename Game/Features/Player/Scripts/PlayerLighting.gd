extends PointLight2D

var _vision_range : Stat

# Called when the node enters the scene tree for the first time.
func _ready():
	_vision_range = GameContext.Player.Attributes.VisionRange
	_vision_range.value_updated.connect(on_vision_value_changed)
	on_vision_value_changed()

func on_vision_value_changed():
	self.scale.x = _vision_range.get_value()
	self.scale.y = _vision_range.get_value()
