extends Node2D

@export var MAX_HP: int
@export var hurtBox: Area2D

func _ready():
	hurtBox.take_damage.connect(TakeDamage)

func TakeDamage(damage):
	print(damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
