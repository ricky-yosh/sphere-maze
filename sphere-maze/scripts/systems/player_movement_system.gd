# player_movement_system.gd
class_name PlayerMovementSystem
extends RefCounted

static func get_movement_direction(input_dir: Vector3, camera_basis: Basis) -> Vector3:
	if input_dir == Vector3.ZERO:
		return Vector3.ZERO
	
	var move_dir = (camera_basis.x * input_dir.x + camera_basis.z * input_dir.z).normalized()
	move_dir.y = 0  # prevent upward tilt from affecting movement
	return move_dir

static func apply_movement(body: RigidBody3D, move_dir: Vector3, movement_data: PlayerMovementData) -> void:
	if move_dir != Vector3.ZERO:
		body.apply_central_force(move_dir * movement_data.speed)

static func apply_jump(body: RigidBody3D, movement_data: PlayerMovementData) -> void:
	if movement_data.use_jump():
		body.apply_impulse(Vector3.UP * movement_data.jump_force)

static func check_ground_collision(body: RigidBody3D) -> bool:
	# Simple ground check using raycast downward
	var space_state = body.get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(
		body.global_position,
		body.global_position + Vector3.DOWN * 0.6  # Slightly more than ball radius
	)
	query.exclude = [body]
	
	var result = space_state.intersect_ray(query)
	return result.size() > 0
