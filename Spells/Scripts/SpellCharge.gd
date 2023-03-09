extends Timer

@onready var SFX = $"../FulChargeSF"

signal stopCharging

func Timeout():
	SFX.play()
