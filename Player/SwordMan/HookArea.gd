extends Area2D

@export var Speed = 200

func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += Speed * direction * delta
