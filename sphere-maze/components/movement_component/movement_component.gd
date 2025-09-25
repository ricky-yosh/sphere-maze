class_name MovementComponent
extends Node
## Allows movement to be added to Rigidbody3D
## 
## Make sure to include [b]MovementData[/b] in the
## initialization of this component

var actor: RigidBody3D
var movement_data: MovementData

func init_component(_actor: RigidBody3D, _movement_data: MovementData) -> void:
	self.actor = _actor
	self.movement_data = _movement_data

#region Public Functions

## Moves player based on Vector3
func handle_movement(input_vector: Vector3) -> void:
	var force = input_vector.normalized() * movement_data.move_speed
	actor.apply_central_force(force)

## Applies upward impulse for jump
func jump() -> void:
	if _is_on_ground():
		actor.apply_central_impulse(Vector3.UP * movement_data.jump_force)

#endregion

#region Private Functions

## Checks if player is touching ground
func _is_on_ground() -> bool:
	var space_state = actor.get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(
		self.global_position,
		self.global_position + Vector3.DOWN * 0.6
	)
	query.exclude = [self]
	
	var result = space_state.intersect_ray(query)
	return not result.is_empty()

#endregion
