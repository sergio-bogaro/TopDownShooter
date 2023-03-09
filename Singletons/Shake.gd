extends Node

var camera: Camera2D
var camera_shake_intensity: float = 0
var camera_shake_duration: float = 0

func setCamera(cameraNode: Camera2D):
	camera = cameraNode

func shake(intensity, duration):
	if intensity > camera_shake_intensity and duration > camera_shake_duration:
		camera_shake_intensity = intensity
		camera_shake_duration = duration

func _process(delta):
	if !camera:
		return
	
	if camera_shake_duration <= 0:
		# Reset the camera when the shaking is done
		camera.offset = Vector2.ZERO
		camera_shake_intensity = 0.0
		camera_shake_duration = 0.0
		return
	
	camera_shake_duration = camera_shake_duration - delta
	
	var offset: Vector2 = Vector2(randf(), randf()) * camera_shake_intensity
	camera.offset = offset
