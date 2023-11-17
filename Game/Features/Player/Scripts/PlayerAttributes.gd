extends Attributes

@onready var MiningLevel : Skill
@onready var SmithingLevel : Skill
@onready var WarfareLevel : Skill

func save():
	var save_dict = super.save()
	save_dict["mining"] = MiningLevel.BaseValue
	save_dict["smithing"] = SmithingLevel.BaseValue
	save_dict["warfare"] = WarfareLevel.BaseValue
	
	return save_dict

