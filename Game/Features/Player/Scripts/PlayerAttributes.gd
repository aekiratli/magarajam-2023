extends Attributes

@onready var MiningLevel : Skill = Skill.new()
@onready var SmithingLevel : Skill = Skill.new()
@onready var WarfareLevel : Skill = Skill.new()

func _ready():
	GameContext.Player.Attributes = self
	GameContext.Player.Resources.Scrap.amount_updated.connect(_on_scrap_amount_updated)
	MiningLevel.set_level(PlayerData.get_value("MiningLevel", 0))
	SmithingLevel.set_level(PlayerData.get_value("SmithingLevel", 0))
	WarfareLevel.set_level(PlayerData.get_value("WarfareLevel", 0))
	
func _on_scrap_amount_updated():
	MiningLevel.on_scrap_amount_updated()
	SmithingLevel.on_scrap_amount_updated()
	WarfareLevel.on_scrap_amount_updated()
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		PlayerData.set_value("MiningLevel", MiningLevel.get_level())
		PlayerData.set_value("SmithingLevel", SmithingLevel.get_level())
		PlayerData.set_value("WarfareLevel", WarfareLevel.get_level())
