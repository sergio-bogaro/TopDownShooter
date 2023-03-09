extends CanvasLayer

@onready var spell_1_cd:Label = $Control/HBoxContainer/Spell_1_CD
@onready var spell_2_cd:Label = $Control/HBoxContainer/Spell_2_CD
@onready var spell_3_cd:Label = $Control/HBoxContainer/Spell_3_CD
@onready var spell_4_cd:Label = $Control/HBoxContainer/Spell_4_CD

var spell_1CD: float = 0
var spell_2CD: float = 0
var spell_3CD: float = 0
var spell_4CD: float = 0

var spell_1_OnCD: bool = false
var spell_2_OnCD: bool = false
var spell_3_OnCD: bool = false
var spell_4_OnCD: bool = false

func setCD(CD: float, spellCode: int):
	match spellCode:
		1:
			spell_1CD = CD
			spell_1_OnCD = true
		2:
			spell_2CD = CD
		3:
			spell_3CD = CD
		4:
			spell_4CD = CD
		_:
			pass

func _process(delta):
	if spell_1_OnCD:
		spell_1CD -= delta
		spell_1_cd.text = str(int(spell_1CD))
		
		if spell_1CD <= 0:
			spell_1_OnCD = false
