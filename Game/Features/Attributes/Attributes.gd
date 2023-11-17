@tool
extends Node

class_name Attributes

# BECAUSE GODOT IS SHIT
# BECAUSE GODOT IS SHIT
@export_category("Base")
@export var _maxHealth : float
@onready var MaxHealth : Stat
@export var _speed : float
@onready var Speed : Stat
@export var _rotationSpeed : float
@onready var RotationSpeed : Stat
@export var _visionRange : float
@onready var VisionRange : Stat
@export_category("Combat")
@export var _attackDamage : float
@onready var AttackDamage : Stat
@export var _attackSpeed : float
@onready var AttackSpeed : Stat
@export var _defense : float
@onready var Defense : Stat
# BECAUSE GODOT IS SHIT
# BECAUSE GODOT IS SHIT

func _ready():
	MaxHealth.set_base_value(_maxHealth)
	Speed.set_base_value(_speed)
	RotationSpeed.set_base_value(_rotationSpeed)
	VisionRange.set_base_value(_visionRange)
	AttackDamage.set_base_value(_attackDamage)
	AttackSpeed.set_base_value(_attackSpeed)
	Defense.set_base_value(_defense)

func save():
	var save_dict = {
		"max_health" : MaxHealth.BaseValue,
		"speed" : Speed.BaseValue,
		"rotation_speed" : RotationSpeed.BaseValue,
		"vision_range" : VisionRange.BaseValue,
		"attack_damage" : AttackDamage.BaseValue,
		"attack_speed" : AttackSpeed.BaseValue,
		"defense" : Defense.BaseValue
	}
	return save_dict

