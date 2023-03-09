extends Node2D

@onready var SwordAnimations: AnimationPlayer = $"../AttackAnimations"
@onready var comboTimer: Timer = $ComboTimer
@onready var character: CharacterBody2D = $".."

var attackNumber: int = 1
var comboTimeToAttack: float = 0.4
var attacking: bool = false

signal finishAttack


func _process(_delta):
	if !attacking:
		rotateSword()

func Attack():
	comboTimer.stop()
	SwordAnimations.play("Attack_" + str(attackNumber))
	
	if attackNumber != 3:
		attacking = true
		attackNumber += 1
	else:
		comboTimer.stop()
		await SwordAnimations.animation_finished
		attackNumber = 1

func isAttacking() -> bool:
	return attacking

func rotateSword():
	var rotationDegree = self.global_position.direction_to(get_global_mouse_position()).angle()
	self.rotation = rotationDegree
	
	var up: bool = self.rotation_degrees < 0 &&  self.rotation_degrees > -180
	self.z_index = -1 if up else 0

func startComboTimer():
	attacking = false
	comboTimer.start(comboTimeToAttack)

func comboTimeout():
	attackNumber = 1
