extends Node2D

@onready var hookPosition: Marker2D = $HookPostion

var hook: PackedScene = preload("res://Player/SwordMan/Hook.tscn")
var hookMoving: bool = false
var hooking: bool = false

var hookToPos: Vector2 = Vector2.ZERO
var enemyHooked: CharacterBody2D 
var hookSpeed: int = 400

signal finishHook

func _input(event):
	if Input.is_action_just_pressed('secondary_attack') && !hookMoving:
		var hookCreated: Area2D = hook.instantiate()
		hookCreated.connect('area_entered', grabEnemy)
		self.get_parent().get_parent().add_child(hookCreated)
		
		hookCreated.global_position = self.global_position
		hookCreated.look_at(get_global_mouse_position())

func _process(delta):
	self.look_at(get_global_mouse_position())
	
	if hooking:
		var direction = enemyHooked.global_position.direction_to(hookToPos)
		var distance = enemyHooked.global_position.distance_to(hookToPos)
		
		if distance > 5:
			enemyHooked.global_position += hookSpeed * direction * delta
		else:
			hooking = false

func grabEnemy(enemy ):
	enemyHooked = enemy.owner
	hookToPos = hookPosition.global_position	
	hooking = true
	
	#var direction = enemyBody.direction_to(self)
	
