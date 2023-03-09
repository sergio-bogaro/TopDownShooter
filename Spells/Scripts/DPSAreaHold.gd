extends Area2D

@export var spellData: SpellData

@onready var castDuration: Timer = $CastDuration

var DamageType: String
var type = "area"

func _ready():
	DamageType = spellData.getSpellType()
	castDuration.start(spellData.maxCastTime)

func DamageTicTimeout():
	var emeiesInside = get_overlapping_areas()
	
	for enemy in emeiesInside:
		enemy.GotHit(self)

func CastDurationTimeout():
	eraseSpell()

func eraseSpell():
	get_parent().casting = false
	queue_free()
