class_name SpringArmService
extends RefCounted

static func handle_spring_arm_movement(spring_arm: Node3D, event: InputEvent, data: SpringArmRepository) -> void:
		spring_arm.rotation.x -= event.relative.y * data.mouse_sensitivity
		spring_arm.rotation_degrees.x = clamp(spring_arm.rotation_degrees.x, data.clamp_min, data.clamp_max)
		spring_arm.rotation.y -= event.relative.x * data.mouse_sensitivity
