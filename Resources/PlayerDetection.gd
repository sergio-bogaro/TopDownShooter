extends Area2D

signal player_detected

func BodyEntered(body):
	emit_signal("player_detected", body)
