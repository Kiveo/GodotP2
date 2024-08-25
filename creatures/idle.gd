extends State

# other possible states
@export var attack_state: State
@export var move_state: State

func enter() -> void:
	super()
	print("idle enter")
	parent.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("attack"):
		print("H1")
		return attack_state
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		return move_state
	return null
