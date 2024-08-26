extends State

# other possible states
@export var attack_state: State
@export var move_state: State

@onready var hit_box_collision_shape: CollisionShape2D = %HitBoxCollisionShape

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO
	hit_box_collision_shape.disabled = true

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("attack"):
		return attack_state
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		return move_state
	return null
