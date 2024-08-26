extends State

@export var idle_state: State
@export var move_state: State
@export var attack_state: State

var initial_velocity: Vector2
var attack_speed: float = move_speed * 2

var current_attack_time: float = 0.0
const ATTACK_TIME: float = 1.0
var attacking: bool = false
var reloaded: bool = false

func enter() -> void:
	super()
	if !reloaded:
		initial_velocity = parent.velocity.sign()
	else: 
		initial_velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down").sign()
	current_attack_time = ATTACK_TIME
	reloaded = false

func process_input(_event: InputEvent) -> State:
	if !attacking and Input.is_action_just_pressed('attack'):
		reloaded = true
		return attack_state
	return null

func process_physics(delta: float) -> State:
	current_attack_time -= delta
	attacking = !current_attack_time <= 0
	if attacking and initial_velocity != Vector2.ZERO:
		parent.velocity += initial_velocity * attack_speed * delta
		parent.move_and_slide()
	elif attacking:
		parent.velocity.x += attack_speed * delta 
		parent.move_and_slide()
	var target = get_tree().get_nodes_in_group('owl_position')[0]
	if !attacking and parent.global_position != target.global_position:
		parent.velocity = Vector2.ZERO
		parent.global_position = target.global_position
	elif !attacking:
		reloaded = false
		return idle_state
	
	return null
