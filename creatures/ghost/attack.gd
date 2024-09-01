extends State

@export var idle_state: State
@export var move_state: State
@export var attack_state: State
@export_category('Custom')
@export var attack_speed: float
@onready var hit_box_collision_shape: CollisionShape2D = %HitBoxCollisionShape
var initial_velocity: Vector2
var current_attack_time: float = 0.0
const ATTACK_TIME: float = 1.0
var attacking: bool = false
var reloaded: bool = false
var tween: Tween
# audio variables
@export var attack_commands: Array[AudioStream]
@onready var owl_audio: AudioStreamPlayer = %OwlAudio
var attack_commands_index: int = 0

func play_attack_audio() -> void:
	if owl_audio.playing: 
		return
	owl_audio.stream = attack_commands[attack_commands_index]
	owl_audio.play()
	attack_commands_index += 1
	if attack_commands_index > 2:
		attack_commands_index = 0

func enter() -> void:
	super()
	hit_box_collision_shape.disabled = false
	if !reloaded:
		initial_velocity = parent.velocity.sign()
	else: 
		initial_velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down").sign()
	current_attack_time = ATTACK_TIME
	reloaded = false
	#audio 
	play_attack_audio()

func process_input(_event: InputEvent) -> State:
	if !attacking:
		var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if sign(direction.x) > 0: parent.facing = 1
		if sign(direction.x) < 0: parent.facing = -1
		if sign(direction.x) != 0: parent.animated_sprite_2d.flip_h = sign(direction.x) < 0.0
	
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
		parent.velocity.x += parent.facing * attack_speed * delta 
		parent.move_and_slide()
	var target = get_tree().get_nodes_in_group('owl_position')[0]
	if !attacking and parent.global_position != target.global_position:
		parent.velocity = Vector2.ZERO
		parent.global_position = target.global_position
		var target_pos = get_tree().get_nodes_in_group('owl_position')[0].global_position
		if tween: tween.kill()
		tween = parent.create_tween()
		tween.tween_property(parent, "position", target_pos, 0.25)
		hit_box_collision_shape.disabled = true
	elif !attacking:
		reloaded = false
		return idle_state
	
	return null
