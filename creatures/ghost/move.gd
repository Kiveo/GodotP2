extends State

@export var idle_state: State
@export var attack_state: State

#var tween: Tween

func enter() -> void:
	super()

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("attack"):
		return attack_state
	return null

func process_physics(_delta: float) -> State:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if !Input.is_action_pressed("hold_player"):
		var target_pos = get_tree().get_nodes_in_group('owl_position')[0].global_position
		var tween = parent.create_tween()
		tween.tween_property(parent, "position", target_pos, 0.25)
	
	parent.velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	parent.animated_sprite_2d.flip_h = direction.x < 0
	parent.move_and_slide()
	
	if direction == Vector2.ZERO:
		return idle_state
	return null
