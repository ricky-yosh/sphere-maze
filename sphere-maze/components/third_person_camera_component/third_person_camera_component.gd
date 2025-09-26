class_name ThirdPersonCameraComponent
extends Node3D
## Connects to CameraPivot and allows Camera to follow Node
## 
## Make sure to include [b]Camera3D[/b] is the child of [b]CameraPivot[/b]
## this allows the camera to properly follow a point

#region Instance Variables

var camera_pivot: Node3D
var third_person_camera_data: ThirdPersonCameraData

#endregion

#region Public Functions

## Instantiates Component
func init_component(_camera_pivot: Node3D, _third_person_camera_data: ThirdPersonCameraData) -> void:
	self.camera_pivot = _camera_pivot
	self.third_person_camera_data = _third_person_camera_data
	
## Rotates Camera Pivot
func rotate_camera_around_pivot(event: InputEvent) -> void:
	if camera_pivot == null:
		return
	if third_person_camera_data == null:
		return
		
	camera_pivot.rotation.x -= event.relative.y * third_person_camera_data.mouse_sensitivity
	camera_pivot.rotation_degrees.x = clamp(
		camera_pivot.rotation_degrees.x,
		third_person_camera_data.clamp_min,
		third_person_camera_data.clamp_max
		)
	camera_pivot.rotation.y -= event.relative.x * third_person_camera_data.mouse_sensitivity

## Move Camera Pivot to Component Transform
func update_camera_pivot_transform() -> void:
	if camera_pivot == null:
		return
		
	camera_pivot.global_position = self.global_position
	
#endregion
