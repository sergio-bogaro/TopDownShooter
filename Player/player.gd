extends CharacterBody2D

@export var MAX_SPEED: int
@export var DASH_SPEED: int
@export var ACCELERATION: int
@export var FRICTION: int

@onready var healthNode: Node2D = $Health
@onready var sprite: Sprite2D = $Sprite
@onready var hurtBox: Area2D = $HurtBoxPlayer
@onready var invencibilityTime: Timer = $InvencibilityTimer

@onready var dash : Node2D = $Dash
@onready var hook : Node2D = $Hook
@onready var attack : Node2D = $Weapon

enum State {
	MOVE,
	ATTACK,
	HOOK,
	DASH
} 

var knockBackTween: Tween
var playerState: State = State.MOVE
var knockBackVector: Vector2 = Vector2.ZERO
var dashVector: Vector2 = Vector2.ZERO
var attackVector: Vector2 = Vector2.ZERO
var speed = Vector2.ZERO


func _ready():
	hurtBox.connect("take_hit", TakeHit)

func _physics_process(_delta):
	match playerState:
		State.MOVE:
			PlayerMovement()
		State.DASH:
			Dash()
		State.ATTACK:
			Attack()

func PlayerMovement():
	var moveVector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	moveVector = moveVector.normalized()
	dashVector = moveVector
	
	if Input.is_action_just_pressed("dash") && moveVector:
		dash.StartDash(0.2)
	
	if moveVector || dashVector: 
		sprite.flip_h = moveVector.x < 0
		speed = speed.move_toward(moveVector * MAX_SPEED, ACCELERATION )
	else:
		speed = speed.move_toward(Vector2.ZERO, FRICTION )
	
	velocity = speed + knockBackVector
	move_and_slide()
	
	stateChangeHandler()

func Dash():
	velocity = dashVector * DASH_SPEED
	move_and_slide()
	
	if !dash.IsDashing():
		playerState = State.MOVE

func Attack():
	velocity = attackVector * MAX_SPEED
	move_and_slide()
	
	if !attack.isAttacking():
		playerState = State.MOVE

func Hook():
	pass

func TakeHit(Damage: int, knockBackStrenght: int, areaPosition: Vector2):
	var knockBackDuration = 0.25
	var knockBackDirection = areaPosition.direction_to(self.global_position)
	var shakeStrenght: int = clamp((knockBackStrenght / 50), 1 , 5)
	
	if knockBackTween:
		knockBackTween.kill()

	knockBackVector = knockBackDirection * knockBackStrenght
	
	knockBackTween = get_tree().create_tween()
	knockBackTween.parallel().tween_property(self, "knockBackVector", Vector2.ZERO, knockBackDuration)
	
	sprite.modulate = Color.RED
	knockBackTween.parallel().tween_property(sprite, "modulate", Color.WHITE, knockBackDuration)
	
	healthNode.TakeDamage(Damage)
	
	Shake.shake(shakeStrenght, 0.2)
	invencibilityTime.start()

func stateChangeHandler():
	if Input.is_action_just_pressed("dash") && dashVector != Vector2.ZERO:
		hurtBox.monitoring = false
		playerState = State.DASH
		dash.StartDash(0.2)
	elif Input.is_action_just_pressed("secondary_attack"):
		pass
	elif Input.is_action_just_pressed("basic_attack"):
		var attackTween = get_tree().create_tween()
		var attackDirection: Vector2 = get_global_mouse_position()
		
		attackVector = global_position.direction_to(attackDirection)
		attackTween.tween_property(self, "attackVector", Vector2.ZERO, 0.2)
		attack.Attack()
		playerState = State.ATTACK
