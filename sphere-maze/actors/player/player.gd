extends RigidBody3D

@export var player_data: PlayerData
@export var camera_pivot: Node3D

@onready var movement_component: MovementComponent = $MovementComponent
@onready var third_person_camera_component: ThirdPersonCameraComponent = %ThirdPersonCameraComponent

func _ready() -> void:
	# Initialize Components
	movement_component.init_component(self, player_data.movement_data)
	third_person_camera_component.init_component(camera_pivot, player_data.third_person_camera_data)
	# Hide mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		third_person_camera_component.rotate_camera_around_pivot(event)

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
		# Make move direction based on facing direction
		var local_dir := Vector3(direction.x, 0, direction.z).normalized()
		var move_dir := camera_pivot.global_basis * local_dir
		# Zero y vector otherwise players will be able to look upward and shoot themselves up
		move_dir.y = 0
		# Normalizing makes speeds equal even if diagonal direction
		move_dir = move_dir.normalized()
		movement_component.handle_movement(move_dir)
		
	if Input.is_action_just_pressed("jump"):
		movement_component.jump()

func _process(_delta: float) -> void:
	third_person_camera_component.update_camera_pivot_transform()
	
