extends RigidBody3D

@export var player_data: PlayerData

@onready var movement_component: Node = $MovementComponent

func _ready() -> void:
	movement_component.init_component(self, player_data.movement_data)

func _physics_process(_delta: float) -> void:
	var direction = Vector3()
	
	if Input.is_action_pressed("forward"):
		direction.z -= 1
	if Input.is_action_pressed("back"):
		direction.z += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
		
	if direction != Vector3.ZERO:
		movement_component.handle_movement(direction)
		
	if Input.is_action_just_pressed("jump"):
		movement_component.jump()
