class_name PlayerMovementService
extends RefCounted

static func handle_movement(body: RigidBody3D, input_vector: Vector3, data: PlayerMovementRepository) -> void:
	if input_vector != Vector3.ZERO:
		var force = input_vector.normalized() * data.move_speed
		body.apply_central_force(force)

static func handle_jump(body: RigidBody3D, data: PlayerMovementRepository) -> void:
	if is_on_ground(body):
		body.apply_central_impulse(Vector3.UP * data.jump_force)

static func is_on_ground(body: RigidBody3D) -> bool:
	var space_state = body.get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(
		body.global_position,
		body.global_position + Vector3.DOWN * 0.6
	)
	query.exclude = [body]
	
	var result = space_state.intersect_ray(query)
	return not result.is_empty()

static func get_movement_direction(input_dir: Vector3, camera_basis: Basis) -> Vector3:
	if input_dir == Vector3.ZERO:
		return Vector3.ZERO
	
	var move_dir = (camera_basis.x * input_dir.x + camera_basis.z * input_dir.z).normalized()
	move_dir.y = 0  # prevent upward tilt from affecting movement
	return move_dir
