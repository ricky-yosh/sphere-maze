extends RigidBody3D

#region Exported Properties

@export var player_movement_data: PlayerMovementRepository
@export var camera_pivot: Node3D

#endregion

#region Process & Event Functions

func _physics_process(_delta) -> void:
	_capture_player_movement_inputs()
	_capture_jump_input()
	_update_camera_pivot_location()

#endregion

#region Private Methods

## Captures and processes player movement input.
func _capture_player_movement_inputs() -> void:
	var input_vector = Vector3()
	
	if Input.is_action_pressed("forward"):
		input_vector.z -= 1
	if Input.is_action_pressed("back"):
		input_vector.z += 1
	if Input.is_action_pressed("left"):
		input_vector.x -= 1
	if Input.is_action_pressed("right"):
		input_vector.x += 1
		
	PlayerMovementService.handle_movement(self, input_vector, player_movement_data)

## Captures and processes jump input.
func _capture_jump_input() -> void:
	if Input.is_action_just_pressed("jump"):
		PlayerMovementService.handle_jump(self, player_movement_data)
		
## Moves camera pivot to the ball location
func _update_camera_pivot_location() -> void:
	if camera_pivot:
		camera_pivot.global_position = global_position
		
#endregion
