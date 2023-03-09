extends Node2D

@onready var dashTimer = $DashTimer

func StartDash(duration):
	dashTimer.start(duration)

func IsDashing():
	return !dashTimer.is_stopped()
