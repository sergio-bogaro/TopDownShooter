extends CharacterBody2D

enum knockBackResistanceValues {
	low = 1,
	normal = 2,
	hight = 3,
	ultra = 4
}

@export var knockBackResistance: knockBackResistanceValues

@onready var hurtBox = $HurtBox
@onready var healthNode = $Health

var knockBackTween
var knockBackVector: Vector2 = Vector2.ZERO


func _ready():
	hurtBox.take_hit.connect(TakeHit)

func _physics_process(delta):
	velocity = knockBackVector
	
	move_and_slide()

func TakeHit(Damage, knockBackStrenght, areaPosition):
	var knockBackDuration = 0.25
	var knockBackDirection = self.to_local(areaPosition)

	knockBackStrenght = (knockBackDirection * -knockBackStrenght) / knockBackResistance
	knockBackVector = knockBackStrenght
	
	knockBackTween = get_tree().create_tween()
	knockBackTween.parallel().tween_property(self, "knockBackVector", Vector2.ZERO, knockBackDuration)
	
	
	healthNode.TakeDamage(Damage)
