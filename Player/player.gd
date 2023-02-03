extends CharacterBody2D


@export var MAX_SPEED: int
@export var ACCELERATION: int
@export var FRICTION: int

var speed = Vector2.ZERO
var canCast: bool = true

@onready var projectile = preload("res://Player/Spells/BasicAttack.tscn")

@onready var basicAttackCD = $Colldowns/BasicAttack

func _physics_process(delta):
	# Code to Handle Player Movement
	var moveVector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	moveVector = moveVector.normalized()
	
	if moveVector: 
		velocity = velocity.move_toward(moveVector * MAX_SPEED, ACCELERATION * delta )
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_slide() 
	
	if Input.is_action_pressed("basic_attack") && canCast:
		#Start attack timer
		basicAttackCD.start()
		canCast = false
		
		#Intanciate the Basic Attack
		var instancedAttack = projectile.instantiate()
		get_tree().current_scene.add_child(instancedAttack)
		instancedAttack.global_position = self.global_position
		
		#Set the Attack Direction
		var attackRotation = self.global_position.direction_to(get_global_mouse_position()).angle()
		instancedAttack.rotation = attackRotation
		

func _on_basic_attack_timeout():
	canCast = true
