extends Node2D

@export var basicAttack: PackedScene
@export var spell_1: PackedScene
@export var spell_2: PackedScene
@export var spell_3: PackedScene
@export var spell_4: PackedScene

@onready var staff = $Staff
@onready var basicAttackCD = $"../Colldowns/BasicAttack"
@onready var spell_1CD = $"../Colldowns/Spell_1"
@onready var spell_2CD = $"../Colldowns/Spell_2"
@onready var spell_3CD = $"../Colldowns/Spell_3"
@onready var spell_4CD = $"../Colldowns/Spell_4"
@onready var spellCharge = $SpellCharge
@onready var animationPlayer: AnimationPlayer = $"../WeaponAnimation"


var charging: bool = false
var casting = false

var startChargeTime: int
var stopChargeTime : int

var basicAttackCDTime: float
var spell_1CDTime: float
var spell_2CDTime: float
var spell_3CDTime: float
var spell_4CDTime: float

var basicAttackSprite: Sprite2D

func _ready():
	getSpellData(basicAttack, 0)
	getSpellData(spell_1, 1)
	getSpellData(spell_2, 2)
	getSpellData(spell_3, 3)
	getSpellData(spell_4, 4)

func _physics_process(_delta):
	self.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("basic_attack") :
		animationPlayer.play("BasicAttack_1")
		staff.visible = true
		
		await animationPlayer.animation_finished
		#staff.visible = false

func _input(_event):
	if Input.is_action_pressed("cast_spell_1") && spell_1CD.is_stopped() && !charging  && !casting:
		spell_1CD.start(spell_1CDTime)
		startCasting(spell_1)
		SpellsUI.setCD(spell_1CDTime, 1)
		
	elif Input.is_action_just_released("cast_spell_1") && charging:
		charging = false
		spellCharge.stop()
		stopChargeTime = Time.get_ticks_msec()
		spellCharge.emit_signal("stopCharging")
	elif Input.is_action_just_released("cast_spell_1") && casting:
		casting.eraseSpell()

func getSpellData(spell, spellCode):
	if !spell:
		return
	
	var SPELL = spell.instantiate()
	var coollDown = SPELL.spellData.spellCooldown
	
	match spellCode:
		1:
			spell_1CDTime = coollDown
		2:
			spell_2CDTime = coollDown
		3:
			spell_3CDTime = coollDown
		4:
			spell_4CDTime = coollDown
		_:
			basicAttackCDTime = coollDown

func startCasting(spellNode):
	var SPELL = spellNode.instantiate()
	var castingMethod = SPELL.spellData.getCastingMethod()
	
	match castingMethod:
		'normal':
			cast(SPELL)
		'charge':
			startCharge(SPELL)
		'castHold':
			casting = true
			self.add_child(SPELL)
			spellTypeHandler(SPELL)
	
			SPELL.global_position = staff.global_position
			casting = SPELL

func startCharge(spell):
	charging = true
	startChargeTime = Time.get_ticks_msec( )
	spellCharge.start(spell.spellData.maxCastTime)
	await spellCharge.stopCharging
	var timePassed = stopChargeTime - startChargeTime
	spell.spellData.charge(timePassed)
	cast(spell)

func cast(spell):
	get_tree().current_scene.add_child(spell)
	spellTypeHandler(spell)

func spellTypeHandler(spell):
	match spell.type:
		"projectile":
			spell.global_position = staff.global_position
			spell.look_at(get_global_mouse_position())
		"area":
			spell.global_position = get_global_mouse_position()
