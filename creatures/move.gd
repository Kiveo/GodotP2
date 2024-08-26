extends State

@export var idle_state: State
@export var attack_state: State

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("attack"):
		return attack_state
	return null

func process_physics(delta: float) -> State:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	parent.velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	parent.animated_sprite_2d.flip_h = direction.x < 0
	parent.move_and_slide()
	
	if direction == Vector2.ZERO:
		return idle_state
	return null
