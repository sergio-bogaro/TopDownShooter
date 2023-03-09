extends Node

enum spellTypes {
	fire,
	ice
}

@export var Damage: int
@export var KnockBackForce: int
@export var DamageTypeSelect: spellTypes

var DamageType: String

func getStatus():
	DamageType = setSpellType()
	
	var spellStatus = {
		Damage: Damage,
		DamageType: DamageType,
		KnockBackForce: KnockBackForce
	}
	
	return spellStatus

func setSpellType():
	match DamageTypeSelect:
		spellTypes.fire:
			return "fire"
		spellTypes.ice:
			return "ice"

