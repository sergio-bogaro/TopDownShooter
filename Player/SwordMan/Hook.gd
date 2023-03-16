extends Node2D

@export var hookCD: float

@onready var hookCDNode: Timer = $HookCD

var hook: PackedScene = preload("res://Player/SwordMan/Hook.tscn")
var enemyHooked: CharacterBody2D 
var hookSpeed: int = 400
var hooking: bool = false

func _input(event):
	if Input.is_action_just_pressed('secondary_attack') && hookCDNode.is_stopped():
		var hookCreated: Area2D = hook.instantiate()
		hookCreated.connect('area_entered', grabEnemy)
		self.get_parent().get_parent().add_child(hookCreated)
		
		hookCreated.global_position = self.global_position
		hookCreated.look_at(get_global_mouse_position())

func _process(delta):
	self.look_at(get_global_mouse_position())
	
	if hooking:
		var direction = enemyHooked.global_position.direction_to(self.global_position)
		var distance = enemyHooked.global_position.distance_to(self.global_position)
		
		if distance > 16:
			enemyHooked.global_position += hookSpeed * direction * delta
		else:
			hooking = false

func grabEnemy(enemy ):
	enemyHooked = enemy.owner
	enemyHooked.StunEnemy()
	hooking = true
