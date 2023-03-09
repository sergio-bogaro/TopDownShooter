extends Node

@export var Enemy: CharacterBody2D

@onready var statusDurationTimer = $StatusDurationTimer
var speedReduction: float

var statusCount: int = 0
var frozen: bool = false 

signal  freeze_target

func addStack():
	statusCount += 1
	resetDuration()
	
	speedReduction = 1 - ( 0.1 * statusCount)
	Enemy.speedReduction = speedReduction
	
	if statusCount == 5:
		Enemy.frozen = true

func resetDuration():
	statusDurationTimer.stop()
	statusDurationTimer.start(4.0)

func StatusDurationTimeout():
	statusCount = 0

func FreezeTarget():
	frozen = true
	emit_signal("freeze_target")
