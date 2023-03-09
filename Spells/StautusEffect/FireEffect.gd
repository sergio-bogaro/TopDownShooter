extends Node

@export var fireDamageByStack: int
@export var statusDuration: float
@export var enemyHealthNode: Node2D

@onready var damageTimer = $DamageTimer
@onready var statusDurationTimer = $StatusDurationTimer

var statusCount: int

func addStack():
	statusCount += 1
	resetDuration()
	
	if statusCount == 1: 
		damageTimer.start()

func resetDuration():
	statusDurationTimer.stop()
	statusDurationTimer.start(statusDuration)

func DamageTimerTimeout():
	var fireDamage = fireDamageByStack * statusCount
	enemyHealthNode.TakeDamage(fireDamage)
	
	damageTimer.start()

func StatusDurationTimeout():
	statusDurationTimer.stop()
	damageTimer.stop()
	
	statusCount = 0

