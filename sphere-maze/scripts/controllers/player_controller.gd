# player_controller.gd
extends RigidBody3D

@export var movement_data: PlayerMovementData
@export var camera_pivot_path: NodePath

var camera_pivot: Node3D

func _ready() -> void:
	camera_pivot = get_node(camera_pivot_path)
	
	# Create default movement data if not assigned
	if not movement_data:
		movement_data = PlayerMovementData.new()

func _physics_process(delta: float) -> void:
	# Check if grounded
	var is_grounded = PlayerMovementSystem.check_ground_collision(self)
	movement_data.set_grounded(is_grounded)
	
	# Get input direction
	var input_dir = _get_input_direction()
	
	# Calculate movement direction relative to camera
	var cam_basis = camera_pivot.global_transform.basis
	var move_dir = PlayerMovementSystem.get_movement_direction(input_dir, cam_basis)
	
	# Apply movement
	PlayerMovementSystem.apply_movement(self, move_dir, movement_data)
	
	# Handle jumping
	if Input.is_action_just_pressed("jump"):
		PlayerMovementSystem.apply_jump(self, movement_data)
	
	# Allow for exiting the game
	if Input.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Make the pivot follow ball's position (no rotation!)
	camera_pivot.global_position = global_position

func _get_input_direction() -> Vector3:
	var input_dir = Vector3.ZERO
	
	if Input.is_action_pressed("forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("back"):
		input_dir.z += 1
	if Input.is_action_pressed("left"):
		input_dir.x -= 1
	if Input.is_action_pressed("right"):
		input_dir.x += 1
	
	return input_dir
