extends Resource

class_name SpellData

enum spellTypes {
	fire,
	ice,
	shadowArts
}

enum castingStyle { 
	normal,
	charge,
	castHold
}

@export_category('Spell Status')
@export var Damage: int
@export var KnockBackForce: int
@export var spellCooldown: float
@export var DamageTypeSelect: spellTypes

@export_category('Cast Styles')
@export var castingMethod: castingStyle
@export var maxCastTime: int

var chargeMultiplicator:float = 1

func getSpellType():
	match DamageTypeSelect:
		spellTypes.fire:
			return "fire"
		spellTypes.ice:
			return "ice"
		spellTypes.shadowArts:
			return "shadowArts"

func getCastingMethod() -> String:
	match castingMethod:
		castingStyle.normal:
			return 'normal'
		castingStyle.charge:
			return 'charge'
		castingStyle.castHold:
			return 'castHold'
		_:
			return 'normal'

func charge(chargeTime):
	var timeCharged = clamp(chargeTime * 0.001, 0 , maxCastTime)
	chargeMultiplicator += timeCharged * 0.5
	var chargedDamage: float = Damage * chargeMultiplicator
	Damage = int (chargedDamage)
