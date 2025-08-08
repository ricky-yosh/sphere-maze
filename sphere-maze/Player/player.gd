# Ball.gd
extends RigidBody3D

@export var speed: float = 20.0
@export var jump_force: float = 5.0
@export var camera_pivot_path: NodePath

var camera_pivot: Node3D

func _ready() -> void:
	camera_pivot = get_node(camera_pivot_path)

func _physics_process(delta: float) -> void:
	var input_dir = Vector3.ZERO

	if Input.is_action_pressed("forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("back"):
		input_dir.z += 1
	if Input.is_action_pressed("left"):
		input_dir.x -= 1
	if Input.is_action_pressed("right"):
		input_dir.x += 1

	if input_dir != Vector3.ZERO:
		# Move relative to camera yaw only
		var cam_basis = camera_pivot.global_transform.basis
		var move_dir = (cam_basis.x * input_dir.x + cam_basis.z * input_dir.z).normalized()
		move_dir.y = 0  # prevent upward tilt from affecting movement
		apply_central_force(move_dir * speed)

	if Input.is_action_just_pressed("jump"):
		apply_impulse(Vector3.UP * jump_force)

	# Make the pivot follow ball's position (no rotation!)
	camera_pivot.global_position = global_position
