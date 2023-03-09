extends Node

@export var enemyHealthNode: Node2D

@onready var effectTimer:Timer = $EffectExplosionTimer
@onready var indicator = $Indicator

var acumulatedDamage:int = 0

func _physics_process(_delta):
	indicator.rotation += 1

func gotHit(damage: int):
	var damageOnStack: float =  damage * 0.3 
	acumulatedDamage += int (damageOnStack)
	
	if effectTimer.is_stopped():
		effectTimer.start()
		indicator.visible = true

func EffectExplosionTimeout():
	enemyHealthNode.TakeDamage(acumulatedDamage)
	indicator.visible = false
	
	acumulatedDamage = 0
