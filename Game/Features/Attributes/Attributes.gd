@tool
extends Node

class_name Attributes

# BECAUSE GODOT IS SHIT
# BECAUSE GODOT IS SHIT
@export_category("Base")
@export var _maxHealth : float
var MaxHealth : Stat
@export var _speed : float
var Speed : Stat
@export var _rotationSpeed : float
var RotationSpeed : Stat
@export var _visionRange : float
var VisionRange : Stat
@export_category("Combat")
@export var _attackDamage : float
var AttackDamage : Stat
@export var _attackSpeed : float
var AttackSpeed : Stat
@export var _defense : float
var Defense : Stat
# BECAUSE GODOT IS SHIT
# BECAUSE GODOT IS SHIT

func _ready():
	MaxHealth.init(_maxHealth)
	Speed.init(_speed)
	RotationSpeed.init(_rotationSpeed)
	VisionRange.init(_visionRange)
	AttackDamage.init(_attackDamage)
	AttackSpeed.init(_attackSpeed)
	Defense.init(_defense)
