extends Area2D

@export var spellData: SpellData

var DamageType: String
var type = "area"

func _ready():
	DamageType = spellData.getSpellType()
	scale = Vector2(spellData.chargeMultiplicator, spellData.chargeMultiplicator)

func DamageTicTimeout():
	var emeiesInside = get_overlapping_areas()
	
	for enemy in emeiesInside:
		enemy.GotHit(self)

func EffectDurationTimeout():
	queue_free()
