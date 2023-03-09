extends Node2D

@onready var PlayerCamera: Camera2D = $Swordman/Camera2D

func _ready():
	Shake.setCamera(PlayerCamera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
