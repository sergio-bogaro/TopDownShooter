extends Node2D

func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += 300 * direction * delta
