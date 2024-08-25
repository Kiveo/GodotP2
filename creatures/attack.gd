extends State

@export var idle_state: State
@export var move_state: State

func enter() -> void:
	super()
	pass

func process_physics(delta: float) -> State:
	print("Attack??")
	return null
