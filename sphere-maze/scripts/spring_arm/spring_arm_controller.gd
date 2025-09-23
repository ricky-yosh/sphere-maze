extends Node3D

#region Exported Properties

@export var spring_arm_data: SpringArmRepository

#endregion

#region Process & Event Functions

func _ready() -> void:
	_hide_mouse()

func _input(event: InputEvent) -> void:
	_capture_menu_input(event)

func _unhandled_input(event: InputEvent):
	_capture_mouse_movement(event)

#endregion

#region Private Methods

## Hides mouse cursor
func _hide_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

## Captures menu input and allows user to use mouse.
func _capture_menu_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
## Capture mouse movement
func _capture_mouse_movement(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		SpringArmService.handle_spring_arm_movement(self, event, spring_arm_data)

#endregion
