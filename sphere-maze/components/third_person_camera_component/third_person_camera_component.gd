extends Node3D

@export var third_person_camera_data: ThirdPersonCameraData

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		self.rotation.x -= event.relative.y * third_person_camera_data.mouse_sensitivity
		self.rotation_degrees.x = clamp(event.rotation_degrees.x, third_person_camera_data.clamp_min, third_person_camera_data.clamp_max)
		self.rotation.y -= event.relative.x * third_person_camera_data.mouse_sensitivity
