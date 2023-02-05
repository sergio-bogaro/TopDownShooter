extends Node2D

@export var Damage: int
@export var ProjectileSpeed: int
@export var KnockBackForce: int
@export var Pierce: bool

func _process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += ProjectileSpeed * direction * delta
