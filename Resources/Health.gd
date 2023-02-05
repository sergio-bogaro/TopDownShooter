extends Node2D

@export var MAX_HP: int
@onready var HP: int = MAX_HP

func TakeDamage(damage):
	HP -= damage
	
	if HP <= 0:
		get_parent().queue_free()
