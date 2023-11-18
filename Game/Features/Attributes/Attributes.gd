@tool
extends Node

class_name Attributes

# BECAUSE GODOT IS SHIT
# BECAUSE GODOT IS SHIT
@export_category("Base")
@export var _maxHealth : float
@onready var MaxHealth : UpgradableStat = UpgradableStat.new()
@export var _speed : float
@onready var Speed : UpgradableStat = UpgradableStat.new()
@export var _rotationSpeed : float
@onready var RotationSpeed : Stat = Stat.new()
@export var _visionRange : float
@onready var VisionRange : Stat = Stat.new()
@export_category("Combat")
@export var _attackDamage : float
@onready var AttackDamage : Stat = Stat.new()
@export var _attackSpeed : float
@onready var AttackSpeed : Stat = Stat.new()
@export var _defense : float
@onready var Defense : Stat = Stat.new()
var Health : float
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
