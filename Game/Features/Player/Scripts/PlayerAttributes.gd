extends Attributes

const StatModifier = preload("res://Game/Features/Attributes/StatModifer.gd")

@export_category("Player")
@export var _maxEnergy : float
@onready var MaxEnergy : UpgradableStat = UpgradableStat.new()
var Energy : float

@onready var Mining : Skill = Skill.new()
@onready var Smithing : Skill = Skill.new()
@onready var Warfare : Skill = Skill.new()

func _ready():
	GameContext.Player.Attributes = self
	
	Mining.set_level(PlayerData.get_value("MiningLevel", 0))
	Smithing.set_level(PlayerData.get_value("SmithingLevel", 0))
	Warfare.set_level(PlayerData.get_value("WarfareLevel", 0))
	
	MaxEnergy.set_base_value(_maxEnergy)
	
	GameManager.game_started.connect(on_game_start)
	
	var mod = StatModifier.new(20, StatModifier.StatModType.PercentAdd, "upgrade");
	MaxHealth.set_level_up_modifier(mod)
	MaxEnergy.set_level_up_modifier(mod)
	Speed.set_level_up_modifier(mod)
	
	super._ready()
	
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		PlayerData.set_value("MiningLevel", Mining.get_level())
		PlayerData.set_value("SmithingLevel", Smithing.get_level())
		PlayerData.set_value("WarfareLevel", Warfare.get_level())
		
func on_game_start():
	Energy = MaxEnergy.get_value()
	Health = MaxHealth.get_value()
