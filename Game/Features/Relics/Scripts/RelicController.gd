extends Node

@onready var Relic = preload("res://Game/Features/Relics/Nodes/relic.tscn")
# create new instance of the Relic scene
@export var number_of_relics : int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_relic(pos: Vector2):
	var relic = Relic.instantiate()
	# move relic to position
	relic.position = pos
	add_child(relic)
