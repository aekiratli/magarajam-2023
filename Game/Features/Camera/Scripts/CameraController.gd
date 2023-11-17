extends Camera2D

@export var speed = 200  # Adjust this value to control the movement speed.
@export var smoothing = 5.0  # Adjust this value to control the smoothing effect.

@onready var MapController = get_node("/root/Main/TileMap")

@onready var target_position = MapController.get_starting_coordinates()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_vector = Vector2(0, 0)

	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1

	input_vector = input_vector.normalized() * speed * delta
	target_position += input_vector

	# Apply smoothing using lerp
	position = position.lerp(target_position, smoothing * delta)
