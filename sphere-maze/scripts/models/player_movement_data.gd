# player_movement_data.gd
class_name PlayerMovementData
extends Resource

@export var speed: float = 20.0
@export var jump_force: float = 5.0
@export var max_jumps: int = 2

var current_jumps: int = 0
var is_grounded: bool = false
var can_jump: bool = true

func reset_jumps() -> void:
	current_jumps = 0
	can_jump = true

func use_jump() -> bool:
	if can_jump and current_jumps < max_jumps:
		current_jumps += 1
		return true
	return false

func set_grounded(grounded: bool) -> void:
	is_grounded = grounded
	if grounded:
		reset_jumps()
