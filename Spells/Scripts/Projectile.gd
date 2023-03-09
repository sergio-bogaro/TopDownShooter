extends Node2D

@export var spellData: SpellData
@export var ProjectileSpeed: int
@export var Pierce: bool

var DamageType: String
var type = "projectile"

func _ready():
	DamageType = spellData.getSpellType()
	scale = Vector2(spellData.chargeMultiplicator, spellData.chargeMultiplicator)

func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += ProjectileSpeed * direction * delta

func HitEnemy(_area):	
	#Verifica se o projetil atravessa o inimgo e caso não apaga o projetil
	if !Pierce:
		queue_free()

func ScreenExited():
	queue_free()
