extends RigidBody3D

@export var player_movement_data: PlayerMovementRepository
@export var camera_pivot: Node3D

#region Virtual Methods

func _ready() -> void:
	_restore_movement_data()

func _physics_process(delta: float) -> void:
	_capture_player_movement_inputs()
	_capture_jump_input()
	_capture_menu_input()
	_update_camera_pivot()

#endregion

#region Private Methods

func _restore_movement_data() -> void:
	if not player_movement_data:
		player_movement_data = PlayerMovementRepository.new()

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

## Captures menu input and allows user to use mouse.
func _capture_menu_input() -> void:
	if Input.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		

func _update_camera_pivot() -> void:
	if camera_pivot:
		# Follow the player, no rotation
		camera_pivot.global_position = global_position
		
#endregion
