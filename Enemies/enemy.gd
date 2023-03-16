extends CharacterBody2D

enum knockBackResistanceValues {
	normal = 1,
	hight = 2
}

@export var ACCELERATION: int
@export var MAX_SPEED: int
@export var FRICTION: int
@export var ATTACK_RANGE: Vector2
@export var stunTime: float 

@export var knockBackResistance: knockBackResistanceValues = knockBackResistanceValues.normal

@onready var playerDetection = $PlayerDetection
@onready var stunTimer: Timer = $StunTimer
@onready var hurtBox = $HurtBox
@onready var healthNode = $Health
@onready var sprite = $Sprite2D

@onready var fireStatusHandler = $StatusEffectHandler/FireEffectHandler
@onready var shadowArtsHandler = $StatusEffectHandler/ShadowArtsEffectHandler
@onready var iceStatusHandler = $StatusEffectHandler/IceEffectHandler

var Player = null
var speedReduction: float = 1
var frozen: bool = false
var stunned: bool = false

var knockBackTween: Tween
var knockBackVector: Vector2 = Vector2.ZERO
var speed: Vector2 = Vector2.ZERO


func _ready():
	hurtBox.take_hit.connect(TakeHit)
	playerDetection.player_detected.connect(PlayerDetected)

func _physics_process(delta):
	var canMove: bool = !frozen && !stunned
	
	if Player && canMove:
		var direction = (Player.global_position - global_position).normalized()
		var movementSpeed = MAX_SPEED * speedReduction
		speed = speed.move_toward(direction * movementSpeed, ACCELERATION * delta) 
	else:
		speed = Vector2.ZERO
		
	velocity = speed + knockBackVector
	move_and_slide()

func StunEnemy():
	stunned = true
	stunTimer.start(stunTime)
	await  stunTimer.timeout 
	stunned = false

func PlayerDetected(area):
	Player = area

func TakeHit(Damage: int, knockBackStrenght: int, areaPosition: Vector2, DamageType:String ):
	var knockBackDuration = 0.25
	var knockBackDirection = areaPosition.direction_to(self.global_position)
	
	if knockBackTween:
		knockBackTween.kill()

	knockBackVector = (knockBackDirection * knockBackStrenght) / knockBackResistance
	
	knockBackTween = get_tree().create_tween()
	knockBackTween.parallel().tween_property(self, "knockBackVector", Vector2.ZERO, knockBackDuration)
	
	sprite.modulate = Color.RED
	knockBackTween.parallel().tween_property(sprite, "modulate", Color.WHITE, knockBackDuration)
	
	healthNode.TakeDamage(Damage)
	
	match DamageType:
		"fire":
			fireStatusHandler.addStack()
		"ice":
			iceStatusHandler.addStack()
		"shadowArts":
			shadowArtsHandler.gotHit(Damage)
